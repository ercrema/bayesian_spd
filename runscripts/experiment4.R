library(nimbleCarbon)
library(rcarbon)
library(coda)
library(here)

a = 3450
b = 1850
ndates = 266 #The observed number of dates in the case study
data("intcal20")
nsim = 20
true.mu = 2800
true.r1 = c(-0.001,-0.002,-0.003)
true.r2 = c(0.001,0.002,0.003)
params=expand.grid(r1=true.r1,r2=true.r2,mu=true.mu)
paramsList = as.list(params)
estimated.r1 = estimated.r1.90hpd.lo = estimated.r1.90hpd.hi = estimated.r2 = estimated.r2.90hpd.lo = estimated.r2.90hpd.hi = estimated.mu = estimated.mu.90hpd.lo = estimated.mu.90hpd.hi = matrix(nrow=nrow(params),ncol=nsim)


modelPlot(model=dDoubleExponentialGrowth,a=a,b=b,params=paramsList,type=c('spaghetti'),interval=0.9,calendar='BCAD',alpha=0.5)


for (k in 1:nrow(params))
{
  for (i in 1:nsim)
  {
    print(paste0('Running ',i,'/',nsim,' of ',k,'/',nrow(params)))
    calendar.dates = replicate(n = ndates,rDoubleExponentialGrowth(a=a,b=b,r1=params$r1[k],r2=params$r2[k],mu=params$mu[k]))
    CRA = round(uncalibrate(calendar.dates)$ccCRA)
    CRAError = rep(20,ndates)
    
    model <- nimbleCode({
      for (i in 1:N){
        theta[i] ~ dDoubleExponentialGrowth(a=a,b=b,r1=r1,r2=r2,mu=changept);
        mu[i] <- interpLin(z=theta[i], x=calBP[], y=C14BP[]);
        sigmaCurve[i] <- interpLin(z=theta[i], x=calBP[], y=C14err[]);
        sd[i] <- (sigma[i]^2+sigmaCurve[i]^2)^(1/2);
        X[i] ~ dnorm(mean=mu[i],sd=sd[i]);
      }
      r1 ~ dnorm(0,sd=0.1);
      r2 ~ dnorm(0,sd=0.1);
      chp ~ dunif(b+1,a-1);
      changept <- round(chp);
    })  
    
    constants <- list(N=length(CRA),calBP=intcal20$CalBP,C14BP=intcal20$C14Age,C14err=intcal20$C14Age.sigma,a=a,b=b)
    data <- list(X=CRA,sigma=CRAError)
    medDates = medCal(calibrate(CRA,CRAError,verbose=FALSE))
    if(any(medDates>a|medDates<b)){medDates[medDates>a]=a;medDates[medDates<b]=b}
    runModel <- nimbleModel(code = model, constants = constants,data = data,inits = list(r1=1/500,r2=1/500,chp=2500,theta=medDates))
    mcmc.output <- nimbleMCMC(model = runModel,niter = 10000, nchains = 1, thin=1,nburnin = 3000,summary = TRUE,monitors=c('r1','r2','chp'),progressBar=FALSE)
    estimated.r1[k,i]=median(mcmc.output$samples[,'r1'])
    estimated.r2[k,i]=median(mcmc.output$samples[,'r2'])
    estimated.mu[k,i]=median(mcmc.output$samples[,'chp'])
    
    estimated.r1.90hpd.lo[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r1']),prob = 0.90)[1]
    estimated.r1.90hpd.hi[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r1']),prob = 0.90)[2]
    estimated.r2.90hpd.lo[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r2']),prob = 0.90)[1]
    estimated.r2.90hpd.hi[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r2']),prob = 0.90)[2]
    estimated.mu.90hpd.lo[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'chp']),prob = 0.90)[1]
    estimated.mu.90hpd.hi[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'chp']),prob = 0.90)[2]
  }
}

save(ndates,params,estimated.r1,estimated.r2,estimated.mu,estimated.r1.90hpd.hi,estimated.r1.90hpd.lo,estimated.r2.90hpd.hi,estimated.r2.90hpd.lo,estimated.mu.90hpd.hi,estimated.mu.90hpd.lo,file=here('R_images','experiment4_results.RData'))
