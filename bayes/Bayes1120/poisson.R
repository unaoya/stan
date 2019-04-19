x <- c(8,4,5,5,7,9,7,5,5,4)
N <- length(x)
d <- list(x=x, N=N)
fit2 <- stan('poisson.stan', data=d)
fit2
stan_trace(fit2)
stan_hist(fit2)
stan_dens(fit2)
stan_ac(fit2,pars='lambda',separate_chains = TRUE)
lambda <- rstan::extract(fit2)$lambda
lambda
dpois(1,lambda=3)
#lambda=3のポアソン分布でx=1となる確率
dpois(3,lambda)
mean(dpois(3,lambda))
mean(dpois(0,lambda))+mean(dpois(1,lambda))+mean(dpois(2,lambda))

