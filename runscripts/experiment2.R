library(nimbleCarbon)
library(rcarbon)
library(coda)
library(here)

## Experiment 2 ####
timeRange=matrix(c(7000,2800,6400,2200),ncol=2,nrow=2,dimnames = list(c('1','2'),c('a','b')))
data("intcal20")
nsim = 20
ndates = 300
true.r = 0.003
estimated.r = estimated.90hpd.lo = estimated.90hpd.hi =matrix(nrow=nrow(timeRange),ncol=nsim)

for (k in 1:nrow(timeRange))
{
  for (i in 1:nsim)
  {
    print(paste0('Running ',i,'/',nsim,' of ',k,'/',nrow(timeRange)))
    a = timeRange[k,'a']
    b = timeRange[k,'b']
    calendar.dates = replicate(n = ndates,rExponentialGrowth(a=a,b=b,r=true.r))
    CRA = round(uncalibrate(calendar.dates)$ccCRA)
    CRAError = rep(20,ndates)
    
    model <- nimbleCode({
      for (i in 1:N){
        theta[i] ~ dExponentialGrowth(a=a,b=b,r=r);
        mu[i] <- interpLin(z=theta[i], x=calBP[], y=C14BP[]);
        sigmaCurve[i] <- interpLin(z=theta[i], x=calBP[], y=C14err[]);
        sd[i] <- (sigma[i]^2+sigmaCurve[i]^2)^(1/2);
        X[i] ~ dnorm(mean=mu[i],sd=sd[i]);
      }
      r ~ dexp(500);
    })  
    
    constants <- list(N=length(CRA),calBP=intcal20$CalBP,C14BP=intcal20$C14Age,C14err=intcal20$C14Age.sigma,a=a,b=b)
    data <- list(X=CRA,sigma=CRAError)
    medDates = medCal(calibrate(CRA,CRAError,verbose=FALSE))
    if(any(medDates>a|medDates<b)){medDates[medDates>a]=a;medDates[medDates<b]=b}
    runModel <- nimbleModel(code = model, constants = constants,data = data,inits = list(r=1/500,theta=medDates))
    mcmc.output <- nimbleMCMC(model = runModel,niter = 10000, nchains = 1, thin=1,nburnin = 3000,summary = TRUE,monitors=c('r'),progressBar=FALSE)
    estimated.r[k,i]=median(mcmc.output$samples[,'r'])
    estimated.90hpd.lo[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r']),prob = 0.90)[1]
    estimated.90hpd.hi[k,i]=HPDinterval(mcmc(mcmc.output$samples[,'r']),prob = 0.90)[2]
  }
}

save(timeRange,true.r,estimated.r,estimated.90hpd.lo,estimated.90hpd.hi,file=here('R_images','experiment2_results.RData'))
