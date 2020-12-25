library(here)
library(latex2exp)
library(nimbleCarbon)

### Experiments 1 & 2 ####

## Experiment 1
pdf(file = here('manuscript','figures','figure_exp1_2.pdf'),width = 7,height = 7)
par(mfrow=c(2,1),mar=c(4,4,3,1))
load(here('R_images','experiment1_results.RData'))
plot(estimated.r[1,],pch=20,ylim=c(0,0.006),xlab='',ylab='',type='n',main='a',axes=F)
axis(2)
mtext('r',side=2,line=3,las=2)
#mtext('Simulation Number',side=1,line=2.5,las=1)

arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col='black',length = 0.05,code = 3,angle = 90)
points(estimated.r[1,],pch=20)
arrows(x0=1:20,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col='black',length = 0.05,code = 3,angle = 90)
points(estimated.r[2,],pch=20)
arrows(x0=1:20,y0=estimated.90hpd.hi[3,],y1=estimated.90hpd.lo[3,],col='black',length = 0.05,code = 3,angle = 90)
points(estimated.r[3,],pch=20)

abline(h=true.r[1],lty=2)
abline(h=true.r[2],lty=2)
abline(h=true.r[3],lty=2)

## Experiment 2
load(here('R_images','experiment2_results.RData'))
plot(c(1:20,22:41),c(estimated.r[1,],estimated.r[2,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(0.000,0.006),main='b')
mtext('r',side=2,line=3,las=2)
#mtext('Simulation Number',side=1,line=2.5,las=1)
arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col='black',length = 0.05,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col='black',length = 0.05,code = 3,angle = 90)
abline(v=21)
abline(h=true.r,lty=2)
axis(2)
#axis(1,at=c(1,5,10,15,20,22,26,31,36,41),labels=c(1,5,10,15,20,1,5,10,15,20))
text(x=10,y=0.0055,'7000-6400 cal BP\n Steep Portion')
text(x=31,y=0.0055,'2800-2200 cal BP\n Plateau')
dev.off()








### Experiment 3a ####
pdf(file = here('manuscript','figures','figure_exp3a.pdf'),width = 8,height = 5)
load(here('R_images','experiment3a_results.RData'))
plot(c(1:20,22:41,43:62),c(estimated.r[1,],estimated.r[2,],estimated.r[3,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(0.002,0.009),type='n')
mtext('r',side=2,line=3,las=2)
arrows(x0=1:20,y0=estimated.90hpd.hi[1,],y1=estimated.90hpd.lo[1,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.90hpd.hi[2,],y1=estimated.90hpd.lo[2,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.90hpd.hi[3,],y1=estimated.90hpd.lo[3,],col='black',length = 0.02,code = 3,angle = 90)
points(1:20,estimated.r[1,],pch=20)
points(22:41,estimated.r[2,],pch=20)
points(43:62,estimated.r[3,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(h=true.r,lty=2)
axis(2)
axis(1,at=c(10,31,52),labels=c('n=250','n=100','n=50'),tick=FALSE,cex.axis=1.5)
dev.off()


### Experiment 3b ####
load(here('R_images','experiment3b_results.RData'))
pdf(file = here('manuscript','figures','figure_exp3b.pdf'),width = 6,height = 8)
par(mfrow=c(3,1),mar=c(2,4,1,1))
plot(c(1:20,22:41,43:62,64:83),c(estimated.r1[1,],estimated.r1[2,],estimated.r1[3,],estimated.r1[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(-0.003,0.006),type='n')
mtext(TeX('$r_1$'),side=2,line=2.5,las=2)
arrows(x0=1:20,y0=estimated.r1.90hpd.hi[1,],y1=estimated.r1.90hpd.lo[1,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.r1.90hpd.hi[2,],y1=estimated.r1.90hpd.lo[2,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.r1.90hpd.hi[3,],y1=estimated.r1.90hpd.lo[3,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.r1.90hpd.hi[2,],y1=estimated.r1.90hpd.lo[2,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.r1.90hpd.hi[3,],y1=estimated.r1.90hpd.lo[3,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.r1.90hpd.hi[4,],y1=estimated.r1.90hpd.lo[4,],col='black',length = 0.02,code = 3,angle = 90)
points(1:20,estimated.r1[1,],pch=20)
points(22:41,estimated.r1[2,],pch=20)
points(64:83,estimated.r1[3,],pch=20)
points(64:83,estimated.r1[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.r1,lty=2)
axis(side=2)

plot(c(1:20,22:41,43:62,64:83),c(estimated.mu[1,],estimated.mu[2,],estimated.mu[3,],estimated.mu[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(6000,4000),type='n')
mtext(TeX('$\\mu$'),side=2,line=2.5,las=2)
arrows(x0=1:20,y0=estimated.mu.90hpd.hi[1,],y1=estimated.mu.90hpd.lo[1,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.mu.90hpd.hi[2,],y1=estimated.mu.90hpd.lo[2,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.mu.90hpd.hi[3,],y1=estimated.mu.90hpd.lo[3,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.mu.90hpd.hi[4,],y1=estimated.mu.90hpd.lo[4,],col='black',length = 0.02,code = 3,angle = 90)
points(1:20,estimated.mu[1,],pch=20)
points(22:41,estimated.mu[2,],pch=20)
points(43:62,estimated.mu[3,],pch=20)
points(64:83,estimated.mu[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.mu,lty=2)
axis(side=2)

plot(c(1:20,22:41,43:62,64:83),c(estimated.r2[1,],estimated.r2[2,],estimated.r2[3,],estimated.r2[4,]),pch=20,ylab='',xlab='',axes=FALSE,ylim=c(-0.005,0.003),type='n')
mtext(TeX('$r_2$'),side=2,line=2.5,las=2)
arrows(x0=1:20,y0=estimated.r2.90hpd.hi[1,],y1=estimated.r2.90hpd.lo[1,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=22:41,y0=estimated.r2.90hpd.hi[2,],y1=estimated.r2.90hpd.lo[2,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=43:62,y0=estimated.r2.90hpd.hi[3,],y1=estimated.r2.90hpd.lo[3,],col='black',length = 0.02,code = 3,angle = 90)
arrows(x0=64:83,y0=estimated.r2.90hpd.hi[4,],y1=estimated.r2.90hpd.lo[4,],col='black',length = 0.02,code = 3,angle = 90)
points(1:20,estimated.r2[1,],pch=20)
points(22:41,estimated.r2[2,],pch=20)
points(43:62,estimated.r2[3,],pch=20)
points(64:83,estimated.r2[4,],pch=20)
abline(v=21,lty=3)
abline(v=42,lty=3)
abline(v=63,lty=3)
abline(h=true.r2,lty=2)
axis(side=2)
axis(1,at=c(10,31,52,73),labels=c('n=500','n=250','n=100','n=50'),tick=FALSE,cex.axis=1.5)
dev.off()




### Experiment 4 ####
load(here('R_images','experiment4_results.RData'))
pdf(file = here('manuscript','figures','figure_exp4.pdf'),width = 9,height = 8)
layout(matrix(1:36,12,3),heights=c(rep(c(0.1,0.3,0.3,0.3),3)),widths = c(1,1,1))


for (i in 1:9)
{
  par(mar=c(0,0,0,0))
  plot(0,0,xlim=c(0,1),ylim=c(0,1),xlab='',ylab='',axes=FALSE,type='n')
  text(0.55,0.5,paste('Setting',i),cex=1.2)
  par(mar=c(1,3,0,0)+0.5)
  
  plot(estimated.r1[i,],pch=20,ylim=c(params[i,'r1']-0.003,params[i,'r1']+0.003),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.8)
  mtext(TeX('$r_1$'),2,line=2,las=2,cex=0.8)
  abline(h=params[i,'r1'],lty=2)
  arrows(x0=1:20,y0=estimated.r1.90hpd.hi[i,],y1=estimated.r1.90hpd.lo[i,],col='black',length = 0.02,code = 3,angle = 90)
  
  plot(estimated.mu[i,],pch=20,ylim=c(3450,1850),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.8)
  mtext(TeX('$\\mu$'),2,line=2,las=2,cex=0.8)
  abline(h=2800,lty=2)
  arrows(x0=1:20,y0=estimated.mu.90hpd.hi[i,],y1=estimated.mu.90hpd.lo[i,],col='black',length = 0.02,code = 3,angle = 90)
  
  
  plot(estimated.r2[i,],pch=20,ylim=c(params[i,'r2']-0.003,params[i,'r2']+0.003),xlab='',ylab='',axes=FALSE);
  axis(2,padj=1,tck=-0.07,cex.axis=0.8)
  mtext(TeX('$r_2$'),2,line=2,las=2,cex=0.8)
  abline(h=params[i,'r2'],lty=2)
  arrows(x0=1:20,y0=estimated.r2.90hpd.hi[i,],y1=estimated.r2.90hpd.lo[i,],col='black',length = 0.02,code = 3,angle = 90)
}
dev.off()

### Experiment 4 Settings ####
pdf(file = here('manuscript','figures','figure_exp4_settings.pdf'),width = 9,height = 8)

a = 3450
b = 1850
true.mu = 2800
true.r1 = c(-0.001,-0.002,-0.003)
true.r2 = c(0.001,0.002,0.003)
params=expand.grid(r1=true.r1,r2=true.r2,mu=true.mu)

par(mfcol=c(3,3),mar=c(4,4,3,2))
for (i in 1:9)
{
  prdens = dDoubleExponentialGrowth(a:b,a=a,b=b,r1=params$r1[i],r2=params$r2[i],mu=params$mu[i],log=FALSE)
  plotyears = BPtoBCAD(a:b)
  plot(plotyears,prdens,type='n',ylim=c(0,0.0028),xlab='Years BC/AD',ylab='Probability Mass',main=paste('Setting ',i),font.main = 1,cex.main=1.2,axes=FALSE)
  polygon(c(plotyears,rev(plotyears)),c(prdens,rep(0,length(a:b))),border=NA,col='darkgrey')
  axis(2)
  axis(1,at=c(-1500,-1000,-500,-1),labels=c(1500,1000,500,1))
}

dev.off()
