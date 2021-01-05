# Load libraries ####
library(nimbleCarbon)
library(coda)
library(here)

# Load MCMC results and observed data ####
load(here('R_images','mcmc.m1.samples.RData'))
load(here('R_images','mcmc.m2.samples.RData'))
load(here('R_images','mcmc.m3.samples.RData'))
load(here('R_images','cleaned_data.RData')) 

# Compute Gelman-Rubin Convergence Statistics and ESS ####
rhat.m1=gelman.diag(mcmc.m1.samples$samples)
rhat.m2=gelman.diag(mcmc.m2.samples$samples)
rhat.m3=gelman.diag(mcmc.m3.samples$samples)

ess.m1=effectiveSize(mcmc.m1.samples$samples)
ess.m2=effectiveSize(mcmc.m2.samples$samples)
ess.m3=effectiveSize(mcmc.m3.samples$samples)

# Posterior Predictive Check ####
params.m1 = list(r = c(mcmc.m1.samples$samples$chain1[,'r'],mcmc.m1.samples$samples$chain2[,'r'],mcmc.m1.samples$samples$chain3[,'r']))
params.m2 = list(r1 = c(mcmc.m2.samples$samples$chain1[,'r1'],mcmc.m2.samples$samples$chain2[,'r1'],mcmc.m2.samples$samples$chain3[,'r1']),
                 r2 = c(mcmc.m2.samples$samples$chain1[,'r2'],mcmc.m2.samples$samples$chain2[,'r2'],mcmc.m2.samples$samples$chain3[,'r2']),
                 mu = round(c(mcmc.m2.samples$samples$chain1[,'chp'],mcmc.m2.samples$samples$chain2[,'chp'],mcmc.m2.samples$samples$chain3[,'chp'])))
params.m3 = list(r1 = c(mcmc.m3.samples$samples$chain1[,'r1'],mcmc.m3.samples$samples$chain2[,'r1'],mcmc.m3.samples$samples$chain3[,'r1']),
                 r2 = c(mcmc.m3.samples$samples$chain1[,'r2'],mcmc.m3.samples$samples$chain2[,'r2'],mcmc.m3.samples$samples$chain3[,'r2']),
                 k = c(mcmc.m3.samples$samples$chain1[,'k'],mcmc.m3.samples$samples$chain2[,'k'],mcmc.m3.samples$samples$chain3[,'k']),
                 mu = round(c(mcmc.m3.samples$samples$chain1[,'chp'],mcmc.m3.samples$samples$chain2[,'chp'],mcmc.m3.samples$samples$chain3[,'chp'])))

pp.check.m1.calsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dExponentialGrowth,a = 3400,b=1850,params=params.m1,nsim = 500,ncores = 5,verbose=FALSE,method='calsample')
pp.check.m1.uncalsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dExponentialGrowth,a = 3400,b=1850,params=params.m1,nsim = 500,ncores = 5,verbose=FALSE,method='uncalsample')

pp.check.m2.calsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dDoubleExponentialGrowth,a = 3400,b=1850,params=params.m2,nsim = 500,ncores = 5,verbose=FALSE,method='calsample')
pp.check.m2.uncalsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dDoubleExponentialGrowth,a = 3400,b=1850,params=params.m2,nsim = 500,ncores = 5,verbose=FALSE,method='uncalsample')

pp.check.m3.calsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dExponentialLogisticGrowth,a = 3400,b=1850,params=params.m3,nsim = 500,ncores = 5,verbose=FALSE,method='calsample')
pp.check.m3.uncalsample=postPredSPD(obs.data$CRA,obs.data$Error,calCurve = 'intcal20',model = dExponentialLogisticGrowth,a = 3400,b=1850,params=params.m3,nsim = 500,ncores = 5,verbose=FALSE,method='uncalsample')


save(rhat.m1,rhat.m2,rhat.m2,ess.m1,ess.m2,ess.m3,params.m1,params.m2,params.m3,pp.check.m1.calsample,pp.check.m1.uncalsample,pp.check.m2.calsample,pp.check.m2.uncalsample,pp.check.m3.calsample,pp.check.m3.uncalsample, file=here('R_images','mcmc_diagnostics_and_ppcheck.RData'))
