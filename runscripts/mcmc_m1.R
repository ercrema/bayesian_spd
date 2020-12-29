# Load Relevant Libraries ####
library(rcarbon)
library(nimbleCarbon)
library(coda)
library(here)
# Load Cleaned Data ####
load(here('R_images','cleaned_data.RData')) 

# Define Model ####
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

# Define Constants and Data ####
data(intcal20)
constants <- list(N=length(obs.caldates),calBP=intcal20$CalBP,C14BP=intcal20$C14Age,C14err=intcal20$C14Age.sigma)
data <- list(X=obs.data$CRA,sigma=obs.data$Error)

# Define Initialisation Function
initsFunction.m1 = function() list(r=rexp(1,1/0.0004),theta=as.numeric(obs.data$MedCalDate))

# Run MCMC ####
mcmc.m1.samples<- nimbleMCMC(code = m1,constants = constants,data = data,niter = 100000, nchains = 4, thin=5, nburnin = 10000, summary = TRUE, monitors=c('r','theta'),WAIC=TRUE,samplesAsCodaMCMC=TRUE,inits=initsFunction.m1)

# Quick Summaries
gelman.diag(mcmc.m1.samples$samples)$psrf[1:2,]

# Save output
save(mcmc.m1.samples,file=here('R_images','mcmc.m1.samples.RData'))
