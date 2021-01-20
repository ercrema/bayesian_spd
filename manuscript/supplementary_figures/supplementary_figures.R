# Load R Images & Packages ####
library(here)
library(rcarbon)
library(nimbleCarbon)
library(truncnorm)
library(rworldmap) 
library(maptools) 
library(maps) 
library(GISTools) 
library(mapdata) 
library(coda)
library(latex2exp)
library(dplyr)
library(oxcAAR)
load(here('R_images','cleaned_data.RData'))
load(here('R_images','mcmc.m1.samples.RData'))
load(here('R_images','mcmc.m2.samples.RData'))
load(here('R_images','mcmc.m3.samples.RData'))
load(here('R_images','mcmc_diagnostics_and_ppcheck.RData'))
load(here('data','c14data.RData'))


### Figure S1  ####
pdf(file=here('manuscript','supplementary_figures','figureS1.pdf'),width = 6,height = 7)
obs.sites.dates = left_join(obs.data,c14data,by=c('LabCode'='LabCode'))
c14samples=table(obs.sites.dates$Prefecture)

# Plot Maps
basemap <- getMap(resolution = "high")
layout(matrix(c(1,1,1,2),2,2),height=c(0.6,0.4),widths = c(0.6,0.4))

plot(basemap, col = "lightgrey", border = NA,xlim = c(129,133),ylim = c(30.9,34.3),xlab='Longitude',ylab='Latitude')

latlong = "+init=epsg:4326"
map("japan","oita",add=TRUE,col="white",lwd=1.5)
map("japan","fukuoka",add=TRUE,col="white",lwd=1.5)
map("japan","kagoshima",add=TRUE,col="white",lwd=1.5)
map("japan","kumamoto",add=TRUE,col="white",lwd=1.5)
map("japan","miyazaki",add=TRUE,col="white",lwd=1.5)
map("japan","nagasaki",add=TRUE,col="white",lwd=1.5)
map("japan","saga",add=TRUE,col="white",lwd=1.5)

text(x=131.4396,y=33.23484,"Oita \n n=21",cex=1.5)
text(x=130.6178,y=33.581,"Fukuoka \n n=41",cex=1.5)
text(x=130.642,y=31.55156,"Kagoshima \n n=118",cex=1.5)
text(x=130.7145,y=32.6647,"Kumamoto \n n=39",cex=1.5)
text(x=131.4718,y=32.22352,"Miyazaki \n n=42",cex=1.5)
text(x=130.078,y=33.35701,"Saga \n n=2",cex=1.5)
text(x=129.6752,y=32.97692,"Nagasaki \n n=25",cex=1.5)
axis(1)
axis(2)
box()

plot(basemap, col = "lightgrey", border = NA,xlim = c(123,147),ylim = c(31,48))
map("japan","oita",add=TRUE,col="black",fill=TRUE)
map("japan","fukuoka",add=TRUE,col="black",fill=TRUE)
map("japan","kagoshima",add=TRUE,col="black",fill=TRUE)
map("japan","kumamoto",add=TRUE,col="black",fill=TRUE)
map("japan","miyazaki",add=TRUE,col="black",fill=TRUE)
map("japan","nagasaki",add=TRUE,col="black",fill=TRUE)
map("japan","saga",add=TRUE,col="black",fill=TRUE)
box()
dev.off()


### Figure S2  ####
pdf(file=here('manuscript','supplementary_figures','figureS2.pdf'),width = 6,height = 6)

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


### Figure S3  ####
pdf(file=here('manuscript','supplementary_figures','figureS3.pdf'),width = 7.5,height = 3.5)
n = 500
set.seed(123)
prior.m1 = list(r=rexp(n,1/0.0004))
prior.m2 = list(r1=rnorm(n,mean=0,sd=0.0004),r2=rexp(n,1/0.0004),mu=round(rtruncnorm(n,mean=2625,a=1850,b=3400)))
prior.m3 = list(r1=rnorm(n,mean=0,sd=0.0004),r2=rexp(n,1/0.0004),mu=round(rtruncnorm(n,mean=2625,a=1850,b=3400)),k=rtruncnorm(n,mean=0.1,sd=0.1,a=0.0001,b=0.5))
par(mfrow=c(1,3),mar=c(5,4,3,0.5))
modelPlot(dExponentialGrowth,a=3450,b=1850,params = prior.m1,nsample = 500,alpha=0.05,main='m1',calendar='BCAD',ylim=c(0,0.0025))
modelPlot(dDoubleExponentialGrowth,a=3450,b=1850,params = prior.m2,nsample = 500,alpha=0.05,main='m2',calendar='BCAD',ylim=c(0,0.0025))
modelPlot(dExponentialLogisticGrowth,a=3450,b=1850,params = prior.m3,nsample = 500,alpha=0.05,main='m3',calendar='BCAD',ylim=c(0,0.0025))
dev.off()


### Figure S4  ####
pdf(file=here('manuscript','supplementary_figures','figureS4.pdf'),width = 6,height = 6)
par(mfrow=c(3,1),mar=c(4,4,2,1))
plot(as.numeric(mcmc.m1.samples$samples$chain1[,'r']),type='l',xlab='MCMC Sample',ylab=TeX('$r$'),main='Chain 1')
plot(as.numeric(mcmc.m1.samples$samples$chain2[,'r']),type='l',xlab='MCMC Sample',ylab=TeX('$r$'),main='Chain 2')
plot(as.numeric(mcmc.m1.samples$samples$chain3[,'r']),type='l',xlab='MCMC Sample',ylab=TeX('$r$'),main='Chain 3')
dev.off()

### Figure S5  ####
pdf(file=here('manuscript','supplementary_figures','figureS5.pdf'),width = 7.5,height = 6)
par(mfrow=c(3,3),mar=c(4,4,2,1))
plot(as.numeric(mcmc.m2.samples$samples$chain1[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 1')
plot(as.numeric(mcmc.m2.samples$samples$chain2[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 2')
plot(as.numeric(mcmc.m2.samples$samples$chain3[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 3')

plot(as.numeric(mcmc.m2.samples$samples$chain1[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 1')
plot(as.numeric(mcmc.m2.samples$samples$chain2[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 2')
plot(as.numeric(mcmc.m2.samples$samples$chain3[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 3')

plot(BPtoBCAD(as.numeric(mcmc.m2.samples$samples$chain1[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 1')
plot(BPtoBCAD(as.numeric(mcmc.m2.samples$samples$chain2[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 2')
plot(BPtoBCAD(as.numeric(mcmc.m2.samples$samples$chain3[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 3')
dev.off()

### Figure S6  ####
pdf(file=here('manuscript','supplementary_figures','figureS6.pdf'),width = 7.5,height = 7.5)
par(mfrow=c(4,3),mar=c(4,4,2,1))
plot(as.numeric(mcmc.m3.samples$samples$chain1[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 1')
plot(as.numeric(mcmc.m3.samples$samples$chain2[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 2')
plot(as.numeric(mcmc.m3.samples$samples$chain3[,'r1']),type='l',xlab='MCMC Sample',ylab=TeX('$r_1$'),main='Chain 3')

plot(as.numeric(mcmc.m3.samples$samples$chain1[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 1')
plot(as.numeric(mcmc.m3.samples$samples$chain2[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 2')
plot(as.numeric(mcmc.m3.samples$samples$chain3[,'r2']),type='l',xlab='MCMC Sample',ylab=TeX('$r_2$'),main='Chain 3')

plot(as.numeric(mcmc.m3.samples$samples$chain1[,'k']),type='l',xlab='MCMC Sample',ylab=TeX('$k$'),main='Chain 1')
plot(as.numeric(mcmc.m3.samples$samples$chain2[,'k']),type='l',xlab='MCMC Sample',ylab=TeX('$k$'),main='Chain 2')
plot(as.numeric(mcmc.m3.samples$samples$chain3[,'k']),type='l',xlab='MCMC Sample',ylab=TeX('$k$'),main='Chain 3')

plot(BPtoBCAD(as.numeric(mcmc.m3.samples$samples$chain1[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 1')
plot(BPtoBCAD(as.numeric(mcmc.m3.samples$samples$chain2[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 2')
plot(BPtoBCAD(as.numeric(mcmc.m3.samples$samples$chain3[,'chp'])),type='l',xlab='MCMC Sample',ylab=TeX('$c$'),main='Chain 3')
dev.off()

### Figure S7  ####
pdf(file=here('manuscript','supplementary_figures','figureS7.pdf'),width = 7,height = 7)
# Re-analyse charred rice dates from Miyamoto 2018
quickSetupOxcal()
oxcalScript = 'Options()
 {
  Resolution=1;
 }; 

Plot()
 {
 R_Combine("Combination Miyamoto 2018")
 {
  R_Date("IAAA-170355",2695,21);
  R_Date("IAAA-170356",2640,22);
  R_Date("IAAA-170357",2709,22);
  R_Date("IAAA-171860",2681,22);
 };
 };
'
# Extract output and compute probability mass for each BCAD date
oxcalResFile <- executeOxcalScript(oxcalScript)
res <- parseFullOxcalOutput(readOxcalOutput(oxcalResFile))
resBCstart = res$`ocd[1]`$likelihood$start
resProb = res$`ocd[1]`$likelihood$prob * res$`ocd[1]`$likelihood$probNorm
resBP = BCADtoBP(seq(resBCstart,by=1,length.out = length(resProb)))

# Compute temporal distance between rice date change points
set.seed(123)
m2_diff = sample(resBP,size=15000,prob=resProb,replace=TRUE) - mcmc.m2.samples$samples$chain1[,'chp'] 
m3_diff =sample(resBP,size=15000,prob=resProb,replace=TRUE) - mcmc.m3.samples$samples$chain1[,'chp']

# Plot Difference and Compute Cumulative Probabilities
par(mfrow=c(2,1))
nsample = 15000
# m2
left = c(HPDinterval(mcmc(m2_diff),prob = 0.90)[1],0)
right = c(0,HPDinterval(mcmc(m2_diff),prob = 0.90)[2])
plotRight=plotLeft=TRUE
if (any(right<0)){left[2]=right[2];plotRight=FALSE}
if (any(left>0)){right[1]=left[1];plotLeft=FALSE}

dens = density(m2_diff)
hpdi.left.x = dens$x[which(dens$x>=left[1]&dens$x<=left[2])]
hpdi.left.y = dens$y[which(dens$x>=left[1]&dens$x<=left[2])]
hpdi.right.x = dens$x[which(dens$x>=right[1]&dens$x<=right[2])]
hpdi.right.y = dens$y[which(dens$x>=right[1]&dens$x<=right[2])]

plot(dens$x,dens$y,type='n',xlab='Years',ylab='Probability Density',axes=FALSE,xlim=c(-500,500),main='m2 changepoint vs earliest occurence of rice')
if(plotLeft){polygon(x=c(hpdi.left.x,rev(hpdi.left.x)),y=c(hpdi.left.y,rep(0,length(hpdi.left.y))),border=NA,col='lightblue')}
if(plotRight){polygon(x=c(hpdi.right.x,rev(hpdi.right.x)),y=c(hpdi.right.y,rep(0,length(hpdi.right.y))),border=NA,col='lightpink')}
lines(dens)
abline(v=0,lty=2,lwd=1.5)
axis(1,at=seq(-1000,1000,100),labels=abs(seq(-1000,1000,100)))
axis(2)
box()
text(x=350,y=median(par('usr')[3:4]),label=paste('Changepoint after\n P=',round(sum(m2_diff>0)/length(m2_diff),2)),cex=0.8)
text(x=-300,y=median(par('usr')[3:4]),label=paste('Changepoint before\n P=',round(sum(m2_diff<0)/length(m2_diff),2)),cex=0.8)
# m3
left = c(HPDinterval(mcmc(m3_diff),prob = 0.90)[1],0)
right = c(0,HPDinterval(mcmc(m3_diff),prob = 0.90)[2])
plotRight=plotLeft=TRUE
if (any(right<0)){left[2]=right[2];plotRight=FALSE}
if (any(left>0)){right[1]=left[1];plotLeft=FALSE}

dens = density(m2_diff)
hpdi.left.x = dens$x[which(dens$x>=left[1]&dens$x<=left[2])]
hpdi.left.y = dens$y[which(dens$x>=left[1]&dens$x<=left[2])]
hpdi.right.x = dens$x[which(dens$x>=right[1]&dens$x<=right[2])]
hpdi.right.y = dens$y[which(dens$x>=right[1]&dens$x<=right[2])]

plot(dens$x,dens$y,type='n',xlab='Years',ylab='Probability Density',axes=FALSE,xlim=c(-500,500),main='m3 changepoint vs earliest occurence of rice')
if(plotLeft){polygon(x=c(hpdi.left.x,rev(hpdi.left.x)),y=c(hpdi.left.y,rep(0,length(hpdi.left.y))),border=NA,col='lightblue')}
if(plotRight){polygon(x=c(hpdi.right.x,rev(hpdi.right.x)),y=c(hpdi.right.y,rep(0,length(hpdi.right.y))),border=NA,col='lightpink')}
lines(dens)
abline(v=0,lty=2,lwd=1.5)
axis(1,at=seq(-1000,1000,100),labels=abs(seq(-1000,1000,100)))
axis(2)
box()
text(x=350,y=median(par('usr')[3:4]),label=paste('Changepoint after\n P=',round(sum(m3_diff>0)/length(m3_diff),2)),cex=0.8)
text(x=-300,y=median(par('usr')[3:4]),label=paste('Changepoint before\n P=',round(sum(m3_diff<0)/length(m3_diff),2)),cex=0.8)
dev.off()
