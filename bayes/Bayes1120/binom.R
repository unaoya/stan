library(rstan)
d <- list(D=28, N=50)
fit <- stan(file='binom.stan', data=d)
fit
stan_trace(fit,pars='p')
stan_hist(fit,pars='p')
stan_dens(fit,pars='p',separate_chains = TRUE)
stan_ac(fit,pars='p',separate_chains = TRUE)

p <- rstan::extract(fit)$p
p
mean(p)
