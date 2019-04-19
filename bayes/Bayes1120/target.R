library(rstan)
x <- rnorm(100)
d <- list(x=x, N=100)
fit <- stan("target.stan", data=d)
fit
