# Load R Images & Packages ####
library(here)
library(rcarbon)
library(nimbleCarbon)

load(here('R_images','mcmc_diagnostics_and_ppcheck.RData'))
load(here('R_images','mcmc.m1.samples.RData'))
load(here('R_images','mcmc.m2.samples.RData'))
load(here('R_images','mcmc.m3.samples.RData'))
options(scipen=9999)
### Table 2 Posterior Summaries ####
table2 = data.frame(Model = c('m1','m2','m2','m2','m3','m3','m3','m3'),
                    Parameters = c('r','r1','r2','c','r1','r2','k','c'),
                    Rhat = c(round(rhat.m1$psrf[1,1],3),round(rhat.m2$psrf[c(2,3,1),1],3),round(rhat.m3$psrf[c(3,4,2,1),1],3)),
                    ESS = c(ess.m1[1],ess.m2[c(2,3,1)],ess.m3[c(3,4,2,1)]),
                    HPD90lower = c(HPDinterval(mcmc.m1.samples$samples,prob=0.90)$chain1[1,1],
                                   HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[2,1],
                                   HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[3,1],
                                   abs(BPtoBCAD(round(HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[1,2],))),
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[3,1],
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[4,1],
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[2,1],
                                   abs(BPtoBCAD(round(HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[1,2])))),
                    HPD90upper = c(HPDinterval(mcmc.m1.samples$samples,prob=0.90)$chain1[1,2],
                                   HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[2,2],
                                   HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[3,2],
                                   abs(BPtoBCAD(round(HPDinterval(mcmc.m2.samples$samples,prob=0.90)$chain1[1,1],))),
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[3,2],
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[4,2],
                                   HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[2,2],
                                   abs(BPtoBCAD(round(HPDinterval(mcmc.m3.samples$samples,prob=0.90)$chain1[1,1])))))
write.csv(table2,here('manuscript','tables','table2.csv'))

### Table 3 Model Comparison ####
m1=mcmc.m1.samples
m2=mcmc.m2.samples
m3=mcmc.m3.samples
table3 = compare.models(m1,m2,m3)
write.csv(table3,here('manuscript','tables','table3.csv'))
