# Load R Images & Packages ####
library(here)
library(rcarbon)
library(nimbleCarbon)
load(here('R_images','cleaned_data.RData'))
load(here('R_images','mcmc.m1.samples.RData'))
load(here('R_images','mcmc.m2.samples.RData'))
load(here('R_images','mcmc.m3.samples.RData'))
load(here('R_images','mcmc_diagnostics_and_ppcheck.RData'))
load(here('R_images','experiment1_results.RData'))
load(here('R_images','experiment2_results.RData'))
load(here('R_images','experiment3a_results.RData'))
load(here('R_images','experiment3b_results.RData'))
load(here('R_images','experiment4_results.RData'))

## NOTE: min width=2.63, max width=7.5, max.height=8.75

### Figure 1 (Site Distribution & SPD) ####

### Figure 2 Experiment 1 & 2 Results ####

### Figure 3 Experiment 3a Results ####

### Figure 4 Experiment 3b Results ####

### Figure 5 Experiment 4 Results ####

### Figure 6 Posterior Distribution of Parameters ####



### Figure 7 Fitted Models ####
tiff(filename = here('manuscript','figures','figure7.tiff'),units = 'in',res=300,width = 7.5, height=3.4)
par(mfrow=c(1,3),mar=c(5,4,3,0.5))
set.seed(123)
modelPlot(dExponentialGrowth,a=3450,b=1850,params = params.m1,nsample = 500,alpha=0.01,main='m1',ylim=c(0,0.0025),calendar='BCAD')
modelPlot(dDoubleExponentialGrowth,a=3450,b=1850,params = params.m2,nsample = 500,alpha=0.01,main='m2',ylim=c(0,0.0025),calendar='BCAD')
modelPlot(dExponentialLogisticGrowth,a=3450,b=1850,params = params.m3,nsample = 500,alpha=0.01,main='m3',ylim=c(0,0.0025),calendar='BCAD')
dev.off()

### Figure 8 Posterior Predictive Checks ####

tiff(filename = here('manuscript','figures','figure8.tiff'),units = 'in',res=300,width = 5, height=6)
par(mfrow=c(3,1),mar=c(5,4,2,0.5))
plot(pp.check.m1.calsample,interval = 0.95,main='model m1',calendar='BCAD')
plot(pp.check.m2.calsample,interval = 0.95,main='model m2')
plot(pp.check.m3.calsample,interval = 0.95,main='model m3')
legend('topleft',legend=c('95% Prediction Interval','Positive Deviation','Negative Deviation','Observed SPD'),lwd=c(5,5,5,1),col=c('lightgrey','red','blue','black'),bty='n')
dev.off()