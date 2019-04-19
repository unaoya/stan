library(rstan)
d <- list(D=15, N=30)
fit1 <- stan('binom1.stan',data=d)
fit1
stan_trace(fit1,pars="p")
