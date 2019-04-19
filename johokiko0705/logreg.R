library(rstan)
N<-20
x <- c(10,9,6,7,8,3,4,9,3,7,10,2,0,5,6,3,1,9,0,0)
hist(x)
d<-list(x=x, N=N, M=10)
fit<-stan(file='logreg.stan',data=d)
fit

stan_dens(fit, pars = c("sigma", "beta"),
          separate_chains = T)
stan_hist(fit, pars='r')
hist(rstan::extract(fit)$r, breaks=-20:20)
stan_hist(fit, pars='p')

hist(rstan::extract(fit)$p)
