library(rstan)

d <- list(D = 28, N = 50)
fit1 <- stan(file = 'binom1.stan', data = d)

fit1
stan_trace(fit1, pars="p")
stan_hist(fit1, pars="p")
stan_dens(fit1, pars="p", separate_chains = T)
stan_ac(fit1, pars="p", separate_chains = T)

p <- rstan::extract(fit1)$p
p
mean(p)
