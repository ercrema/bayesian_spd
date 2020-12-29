# Load Relevant Libraries ####
library(rcarbon)
library(nimbleCarbon)
library(coda)
library(here)
# Load Cleaned Data ####
load(here('R_images','cleaned_data.RData')) 

# Define Models ####
# Exponential Growth
#modelPlot(model=dExponentialGrowth,a=3400,b=1850,params=list(r=rexp(1000, 1/0.0004))) #using as mean rate the average growth rate from Zahid et al 2015

m1 <- nimbleCode({
  for (i in 1:N){
    theta[i] ~ dExponentialGrowth(a=3400,b=1850,r=r);
    mu[i] <- interpLin(z=theta[i], x=calBP[], y=C14BP[]);
    sigmaCurve[i] <- interpLin(z=theta[i], x=calBP[], y=C14err[]);
    sd[i] <- (sigma[i]^2+sigmaCurve[i]^2)^(1/2);
    X[i] ~ dnorm(mean=mu[i],sd=sd[i]);
  }
  r ~ dexp(1/0.0004);
})  

# Double Exponential
#modelPlot(model=dDoubleExponentialGrowth,a=3400,b=1850,params=list(r1=rnorm(1000, sd=0.0004),r2=rnorm(1000, sd=0.0004),mu=round(runif(1000,1851,3339)))) 

#using as sd rate the average growth rate from Zahid et al 2015
m2 <- nimbleCode({
  for (i in 1:N){
    theta[i] ~ dDoubleExponentialGrowth(a=3400,b=1850,r1=r1,r2=r2,mu=changept);
    mu[i] <- interpLin(z=theta[i], x=calBP[], y=C14BP[]);
    sigmaCurve[i] <- interpLin(z=theta[i], x=calBP[], y=C14err[]);
    sd[i] <- (sigma[i]^2+sigmaCurve[i]^2)^(1/2);
    X[i] ~ dnorm(mean=mu[i],sd=sd[i]);
  }
  r1 ~ dnorm(0,sd=0.0004); 
  r2 ~ dnorm(0,sd=0.0004);
  chp ~ dunif(1851,3339);
  changept <- round(chp);
})  


# Define Constants and Data ####
data(intcal20)
constants <- list(N=length(obs.caldates),calBP=intcal20$CalBP,C14BP=intcal20$C14Age,C14err=intcal20$C14Age.sigma)
data <- list(X=obs.data$CRA,sigma=obs.data$Error)

# Define Initialisation Function
initsFunction.m1 = function() list(r=rexp(1,1/0.0004),theta=as.numeric(obs.data$MedCalDate))
initsFunction.m2 = function() list(r1=rnorm(0,sd=0.0004),r2=rnorm(0,sd=0.0004),chp=runif(1851,3339),theta=as.numeric(obs.data$MedCalDate))

# Run MCMC ####
mcmc.m1.samples<- nimbleMCMC(code = m1,constants = constants,data = data,niter = 60000, nchains = 4, thin=5, nburnin = 10000, summary = TRUE, monitors=c('r','theta'),WAIC=TRUE,samplesAsCodaMCMC=TRUE,inits=initsFunction.m1)
mcmc.m1.samples<- nimbleMCMC(code = m2,constants = constants,data = data,niter = 60000, nchains = 4, thin=5, nburnin = 10000, summary = TRUE, monitors=c('r1','r2','chp','theta'),WAIC=TRUE,samplesAsCodaMCMC=TRUE,inits=initsFunction.m2)

# Quick Summaries
gelman.diag(mcmc.m1.samples$samples)$psrf[1:2,]
gelman.diag(mcmc.m2.samples$samples)$psrf[1:3,]
compare.models(mcmc.m1.samples,mcmc.m2.samples)

# Save output
save(mcmc.m1.samples,file=here('R_images','mcmc.m1.samples.RData'))
save(mcmc.m2.samples,file=here('R_images','mcmc.m2.samples.RData'))
