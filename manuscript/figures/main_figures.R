# Load R Images & Packages ####
library(here)
library(rcarbon)
library(nimbleCarbon)
library(latex2exp)
library(dplyr)

load(here('R_images','cleaned_data.RData'))
load(here('R_images','mcmc.m1.samples.RData'))
load(here('R_images','mcmc.m2.samples.RData'))
load(here('R_images','mcmc.m3.samples.RData'))
load(here('R_images','mcmc_diagnostics_and_ppcheck.RData'))

## NOTE (PlosONE) : min width=2.63, max width=7.5, max.height=8.75

### Figure 1 (Observed SPD) ####
tiff(filename = here('manuscript','figures','figure1.tiff'),units = 'in',res=300,width = 6, height=4,pointsize = 8)
obs.spd = spd(obs.caldates,timeRange=c(3400,1850),spdnormalised = T)
plot(obs.spd,calendar='BCAD',runm=100,ylim=c(0,0.002))
lines(BPtoBCAD(obs.spd$grid$calBP),obs.spd$grid$PrDens,type='l',lty=2)
legend('topleft',legend=c('SPD','Rolling Mean (100yrs)'),col=c('lightgrey','black'),lwd=c(8,1),lty=c(1,2))
dev.off()

### Figure 2 Growth Models ####
tiff(filename = here('manuscript','figures','figure2.tiff'),units = 'in',res=300,width = 7.5, height=3,pointsize = 8)
par(mfrow=c(1,3))
plot(320:180,dExponentialGrowth(320:180,a=300,b=200,r=0.02,log=FALSE),xlim=c(320,180),type='h',xlab='Cal BP',ylab='Probability Mass',axes=FALSE,lwd=0.2,cex.lab=1.3,cex.main=1.5,main='m1: Exponential')
axis(1,at=c(300,200),labels=c('a','b'),cex.axis=1.5)
text(x=250,y=0.01,TeX('$r$'),cex=1.5)
box()
plot(320:180,dDoubleExponentialGrowth(320:180,a=300,b=200,mu=265,r1=0.02,r2=-0.01,log=FALSE),xlim=c(320,180),type='h',xlab='Cal BP',ylab='Probability Mass',axes=FALSE,lwd=0.2,cex.lab=1.3,cex.main=1.5,main='m2 Double-Exponential')
axis(1,at=c(300,265,200),labels=c('a','c','b'),cex.axis=1.5)
text(x=290,y=0.01,TeX('$r_1$'),cex=1.5)
text(x=227,y=0.01,TeX('$r_2$'),cex=1.5)
box()
plot(320:180,dExponentialLogisticGrowth(320:180,a=300,b=200,mu=270,k=0.1,r1=-0.02,r2=0.12,log=FALSE),xlim=c(320,180),type='h',xlab='Cal BP',ylab='Probability Mass',axes=FALSE,lwd=0.2,cex.lab=1.3,cex.main=1.5,main='m3 Exponential-Logistic')
axis(1,at=c(300,270,200),labels=c('a','c','b'),cex.axis=1.5)
axis(2,at=dExponentialLogisticGrowth(300,a=300,b=200,mu=270,k=0.1,r1=-0.02,r2=0.12,log=FALSE),labels='k',las=2,cex.axis=1.5)
text(x=287,y=0.0021,TeX('$r_1$'),cex=1.5)
text(x=254,y=0.013,TeX('$r_2$'),cex=1.5)
box()
dev.off()


### Figure 3 Experiment 1 & 2 Results ####
tiff(filename = here('manuscript','figures','figure3.tiff'),units = 'in',res=300,width = 5, height=5,pointsize = 8)
par(mfrow=c(2,1),mar=c(2,3.5,2,1))
## Experiment 1
load(here('R_images','experiment1_results.RData'))
plot(estimated.r[1,],pch=20,ylim=c(0,0.006),xlab='',ylab='',type='n',main='a',axes=F)
axis(2)
mtext('r',side=2,line=3,las=2)
col1 = col2 = col3 = rep('black',length(estimated.r[1,]))
col1[which(estimated.90hpd.hi[1,]<true.r[1] | estimated.90hpd.lo[1,]>true.r[1])] ='darkorange'
arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col=col1,length = 0.03,code = 3,angle = 90)
#points(estimated.r[1,],pch=20)
col2[which(estimated.90hpd.hi[2,]<true.r[2] | estimated.90hpd.lo[2,]>true.r[2])] ='darkorange'
arrows(x0=1:20,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col=col2,length = 0.03,code = 3,angle = 90)
#points(estimated.r[2,],pch=20)
col3[which(estimated.90hpd.hi[3,]<true.r[3] | estimated.90hpd.lo[3,]>true.r[3])] ='darkorange'
arrows(x0=1:20,y0=estimated.90hpd.hi[3,],y1=estimated.90hpd.lo[3,],col=col3,length = 0.03,code = 3,angle = 90)
#points(estimated.r[3,],pch=20)

abline(h=true.r[1],lty=2)
abline(h=true.r[2],lty=2)
abline(h=true.r[3],lty=2)
## Experiment 2
load(here('R_images','experiment2_results.RData'))
plot(c(1:20,22:41),c(estimated.r[1,],estimated.r[2,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(0.000,0.006),main='b',type='n')
mtext('r',side=2,line=3,las=2)
col1 = col2 = rep('black',length(estimated.r[1,]))
col1[which(estimated.90hpd.hi[1,]<true.r | estimated.90hpd.lo[1,]>true.r)] ='darkorange'
col2[which(estimated.90hpd.hi[2,]<true.r | estimated.90hpd.lo[2,]>true.r)] ='darkorange'
arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col=col1,length = 0.03,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col=col2,length = 0.03,code = 3,angle = 90)
abline(v=21)
abline(h=true.r,lty=2)
axis(2)
text(x=10,y=0.0055,'7000-6400 cal BP\n Steep Portion')
text(x=31,y=0.0055,'2800-2200 cal BP\n Plateau')
dev.off()



### Figure 4 Experiment 3a Results ####
tiff(filename = here('manuscript','figures','figure4.tiff'),units = 'in',res=300,width = 6.2, height=3.5)
load(here('R_images','experiment3a_results.RData'))
plot(c(1:20,22:41,43:62),c(estimated.r[1,],estimated.r[2,],estimated.r[3,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(0.002,0.009),type='n')
mtext('r',side=2,line=3,las=2)
col1 = col2 = col3 = rep('black',length(estimated.r[1,]))
col1[which(estimated.90hpd.hi[1,]<true.r | estimated.90hpd.lo[1,]>true.r)] ='darkorange'
col2[which(estimated.90hpd.hi[2,]<true.r | estimated.90hpd.lo[2,]>true.r)] ='darkorange'
col3[which(estimated.90hpd.hi[3,]<true.r | estimated.90hpd.lo[3,]>true.r)] ='darkorange'

arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col=col1,length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col=col2,length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.90hpd.hi[3,],y1=estimated.90hpd.lo[3,],col=col3,length = 0.02,code = 3,angle = 90)
#points(1:20,estimated.r[1,],pch=20)
#points(22:41,estimated.r[2,],pch=20)
#points(43:62,estimated.r[3,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(h=true.r,lty=2)
axis(2)
axis(1,at=c(10,31,52),labels=c('n=250','n=100','n=50'),tick=FALSE,cex.axis=1)
dev.off()

### Figure 5 Experiment 3b Results ####
tiff(filename = here('manuscript','figures','figure5.tiff'),units = 'in',res=300,width = 5, height=6.5)
load(here('R_images','experiment3b_results.RData'))
par(mfrow=c(3,1),mar=c(2,4,1,1))
plot(c(1:20,22:41,43:62,64:83),c(estimated.r1[1,],estimated.r1[2,],estimated.r1[3,],estimated.r1[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(-0.018,0.022),type='n')
mtext(TeX('$r_1$'),side=2,line=2.5,las=2)

col1 = col2 = col3 = col4 = rep('black',length(estimated.r1[1,]))
col1[which(estimated.r1.90hpd.hi[1,]<true.r1 | estimated.r1.90hpd.lo[1,]>true.r1)] ='darkorange'
col2[which(estimated.r1.90hpd.hi[2,]<true.r1 | estimated.r1.90hpd.lo[2,]>true.r1)] ='darkorange'
col3[which(estimated.r1.90hpd.hi[3,]<true.r1 | estimated.r1.90hpd.lo[3,]>true.r1)] ='darkorange'
col4[which(estimated.r1.90hpd.hi[4,]<true.r1 | estimated.r1.90hpd.lo[4,]>true.r1)] ='darkorange'

arrows(x0=1:20,y0=estimated.r1.90hpd.hi[1,],y1=estimated.r1.90hpd.lo[1,],col=col1,length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.r1.90hpd.hi[2,],y1=estimated.r1.90hpd.lo[2,],col=col2,length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.r1.90hpd.hi[3,],y1=estimated.r1.90hpd.lo[3,],col=col3,length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.r1.90hpd.hi[4,],y1=estimated.r1.90hpd.lo[4,],col=col4,length = 0.02,code = 3,angle = 90)
# points(1:20,estimated.r1[1,],pch=20)
# points(22:41,estimated.r1[2,],pch=20)
# points(64:83,estimated.r1[3,],pch=20)
# points(64:83,estimated.r1[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.r1,lty=2)
axis(side=2)

plot(c(1:20,22:41,43:62,64:83),c(estimated.mu[1,],estimated.mu[2,],estimated.mu[3,],estimated.mu[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(6000,4000),type='n')
mtext(TeX('$c$'),side=2,line=2.5,las=2)

col1 = col2 = col3 = col4 = rep('black',length(estimated.mu[1,]))
col1[which(estimated.mu.90hpd.hi[1,]<true.mu | estimated.mu.90hpd.lo[1,]>true.mu)] ='darkorange'
col2[which(estimated.mu.90hpd.hi[2,]<true.mu | estimated.mu.90hpd.lo[2,]>true.mu)] ='darkorange'
col3[which(estimated.mu.90hpd.hi[3,]<true.mu | estimated.mu.90hpd.lo[3,]>true.mu)] ='darkorange'
col4[which(estimated.mu.90hpd.hi[4,]<true.mu | estimated.mu.90hpd.lo[4,]>true.mu)] ='darkorange'

arrows(x0=1:20,y0=estimated.mu.90hpd.hi[1,],y1=estimated.mu.90hpd.lo[1,],col=col1,length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.mu.90hpd.hi[2,],y1=estimated.mu.90hpd.lo[2,],col=col2,length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.mu.90hpd.hi[3,],y1=estimated.mu.90hpd.lo[3,],col=col3,length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.mu.90hpd.hi[4,],y1=estimated.mu.90hpd.lo[4,],col=col4,length = 0.02,code = 3,angle = 90)
# points(1:20,estimated.mu[1,],pch=20)
# points(22:41,estimated.mu[2,],pch=20)
# points(43:62,estimated.mu[3,],pch=20)
# points(64:83,estimated.mu[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.mu,lty=2)
axis(side=2)

plot(c(1:20,22:41,43:62,64:83),c(estimated.r2[1,],estimated.r2[2,],estimated.r2[3,],estimated.r2[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(-0.021,0.019),type='n')
mtext(TeX('$r_2$'),side=2,line=2.5,las=2)

col1 = col2 = col3 = col4 = rep('black',length(estimated.r2[1,]))
col1[which(estimated.r2.90hpd.hi[1,]<true.r2 | estimated.r2.90hpd.lo[1,]>true.r2)] ='darkorange'
col2[which(estimated.r2.90hpd.hi[2,]<true.r2 | estimated.r2.90hpd.lo[2,]>true.r2)] ='darkorange'
col3[which(estimated.r2.90hpd.hi[3,]<true.r2 | estimated.r2.90hpd.lo[3,]>true.r2)] ='darkorange'
col4[which(estimated.r2.90hpd.hi[4,]<true.r2 | estimated.r2.90hpd.lo[4,]>true.r2)] ='darkorange'

arrows(x0=1:20,y0=estimated.r2.90hpd.hi[1,],y1=estimated.r2.90hpd.lo[1,],col=col1,length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.r2.90hpd.hi[2,],y1=estimated.r2.90hpd.lo[2,],col=col2,length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.r2.90hpd.hi[3,],y1=estimated.r2.90hpd.lo[3,],col=col3,length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.r2.90hpd.hi[4,],y1=estimated.r2.90hpd.lo[4,],col=col4,length = 0.02,code = 3,angle = 90)
# points(1:20,estimated.r2[1,],pch=20)
# points(22:41,estimated.r2[2,],pch=20)
# points(43:62,estimated.r2[3,],pch=20)
# points(64:83,estimated.r2[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.r2,lty=2)
axis(side=2)
axis(1,at=c(10,31,52,73),labels=c('n=500','n=250','n=100','n=50'),tick=FALSE,cex.axis=1.5)
dev.off()



### Figure 6 Experiment 4 Results ####
load(here('R_images','experiment4_results.RData'))
tiff(filename = here('manuscript','figures','figure6.tiff'),units = 'in',res=300,width = 6, height=6,pointsize=10)
layout(matrix(1:36,12,3),heights=c(rep(c(0.1,0.3,0.3,0.3),3)),widths = c(1,1,1))

for (i in 1:9)
{
  par(mar=c(0,0,0,0))
  plot(0,0,xlim=c(0,1),ylim=c(0,1),xlab='',ylab='',axes=FALSE,type='n')
  text(0.55,0.5,paste('Setting',i),cex=1.2)
  par(mar=c(1,3,0,0)+0.5)
  
  col = rep('black',20)
  col[which(params[i,'r1']>estimated.r1.90hpd.hi[i,]|params[i,'r1']<estimated.r1.90hpd.lo[i,])]='darkorange'
  plot(estimated.r1[i,],type='n',ylim=c(params[i,'r1']-0.004,params[i,'r1']+0.004),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.6)
  mtext(TeX('$r_1$'),2,line=2,las=2,cex=0.8)
  abline(h=params[i,'r1'],lty=2)
  arrows(x0=1:20,y0=estimated.r1.90hpd.hi[i,],y1=estimated.r1.90hpd.lo[i,],col=col,length = 0.015,code = 3,angle = 90)
  
  col = rep('black',20)
  col[which(2800>estimated.mu.90hpd.hi[i,]|2800<estimated.mu.90hpd.lo[i,])]='darkorange'
  plot(estimated.mu[i,],type='n',ylim=c(3450,1850),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.6)
  mtext(TeX('$c$'),2,line=2,las=2,cex=0.8)
  abline(h=2800,lty=2)
  arrows(x0=1:20,y0=estimated.mu.90hpd.hi[i,],y1=estimated.mu.90hpd.lo[i,],col=col,length = 0.015,code = 3,angle = 90)
  
  col = rep('black',20)
  col[which(params[i,'r2']>estimated.r2.90hpd.hi[i,]|params[i,'r2']<estimated.r2.90hpd.lo[i,])]='darkorange'
  plot(estimated.r2[i,],type='n',ylim=c(params[i,'r2']-0.004,params[i,'r2']+0.004),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.6)
  mtext(TeX('$r_2$'),2,line=2,las=2,cex=0.8)
  abline(h=params[i,'r2'],lty=2)
  arrows(x0=1:20,y0=estimated.r2.90hpd.hi[i,],y1=estimated.r2.90hpd.lo[i,],col='black',length = 0.015,code = 3,angle = 90)
}
dev.off()

### Figure 7 Marginal Posterior Distribution of Parameters ####
tiff(filename = here('manuscript','figures','figure7.tiff'),units = 'in',res=300,width = 7.5, height=4)
par(mfrow=c(2,4),mar=c(3,1.5,2,1.5))
postHPDplot(mcmc.m1.samples$samples$chain1[,'r'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m1:r$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$r$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(mcmc.m2.samples$samples$chain1[,'r1'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m2:r_1$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$r_1$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(mcmc.m2.samples$samples$chain1[,'r2'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m2:r_2$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$r_2$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(abs(round(BPtoBCAD(mcmc.m2.samples$samples$chain1[,'chp']))),xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m2:c$'),axes=F,xlim=c(1000,400))
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$BC$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(mcmc.m3.samples$samples$chain1[,'k'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m3:k$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$k$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(mcmc.m3.samples$samples$chain1[,'r1'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m3:r_1$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$r_1$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(mcmc.m3.samples$samples$chain1[,'r2'],xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m3:r_2$'),axes=F)
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$r_2$'),side = 1,line=1.5,cex = 0.7)
postHPDplot(abs(round(BPtoBCAD(mcmc.m3.samples$samples$chain1[,'chp']))),xlab='',ylab='',show.hpd.val = FALSE,main=TeX('$m3:c$'),axes=F,xlim=c(1000,400))
axis(side=1,cex.axis=0.9,padj=-1);mtext(TeX('$BC$'),side = 1,line=1.5,cex = 0.7)
dev.off()

### Figure 8 Fitted Models ####
tiff(filename = here('manuscript','figures','figure8.tiff'),units = 'in',res=300,width = 7.5, height=3.4)
par(mfrow=c(1,3),mar=c(5,4,3,0.5))
set.seed(123)
modelPlot(dExponentialGrowth,a=3450,b=1850,params = params.m1,nsample = 500,alpha=0.01,main='m1',ylim=c(0,0.0025),calendar='BCAD')
modelPlot(dDoubleExponentialGrowth,a=3450,b=1850,params = params.m2,nsample = 500,alpha=0.01,main='m2',ylim=c(0,0.0025),calendar='BCAD')
modelPlot(dExponentialLogisticGrowth,a=3450,b=1850,params = params.m3,nsample = 500,alpha=0.01,main='m3',ylim=c(0,0.0025),calendar='BCAD')
dev.off()

### Figure 9 Posterior Predictive Checks ####

tiff(filename = here('manuscript','figures','figure9.tiff'),units = 'in',res=300,width = 5, height=6)
par(mfrow=c(3,1),mar=c(5,4,2,0.5))
plot(pp.check.m1.calsample,interval = 0.95,main='model m1',calendar='BCAD')
plot(pp.check.m2.calsample,interval = 0.95,main='model m2',calendar='BCAD')
plot(pp.check.m3.calsample,interval = 0.95,main='model m3',calendar='BCAD')
legend('topleft',legend=c('95% Prediction Interval','Positive Deviation','Negative Deviation','Observed SPD'),lwd=c(5,5,5,1),col=c('lightgrey','red','blue','black'),bty='n')
dev.off()