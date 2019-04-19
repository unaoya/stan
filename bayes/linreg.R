library(rstan)
N<-30
x<-runif(N)
noise<-rnorm(N,mean=0,sd=0.1)
a<-1
b<-2
y<-b+a*x+noise
d<-list(x=x, y=y, N=N)
fit<-stan(file='linreg.stan',data=d)
fit
