library(rstan)
N<-20
x <- c(10,9,6,7,8,3,4,9,3,7,10,2,0,5,6,3,1,9,0,0)
d<-list(x=x, N=N, M=10)
fit<-stan(file='logreg.stan',data=d)
fit
