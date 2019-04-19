library(rstan)
d <- list(D=28,N=50)
fit1 <- stan('binom1.stan', data=d)
fit1
stan_trace(fit1,pars="p")
stan_hist(fit1,pars="p")

rstan::extract(fit1)
p <- rstan::extract(fit1)$p
mean(p)
