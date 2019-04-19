# パッケージlooを用いたWAICの算出例
library(rstan)
N <- 100
Y <- rnorm(N)
d <- list(N=N, Y=Y)
fit <- stan('waic_test.stan', data=d)
fit
library('loo')
log_lik <- extract_log_lik(fit)
waic <- waic(log_lik)
waic
