x <- c(10,9,6,7,8,3,4,9,3,7,10,2,0,5,6,3,1,9,0,0)
hist(x,breaks=0:10)
d <- list(x=x, N=20, M=10)
library(rstan)
fit <- stan(file='logreg.stan',data=d)
fit
stan_hist(fit, pars='p')
p <- rstan::extract(fit)$p
p
par(mfrow=c(1,2))
hist(x,breaks=0:10)
hist(p)
