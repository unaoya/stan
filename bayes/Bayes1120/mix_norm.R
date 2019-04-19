x <- c(rnorm(300, -1, 1), rnorm(700, 10, 3))
d <- list(N=length(x), M=2, x=x)
hist(x)
library(rstan)
fit <- stan('mix_norm2.stan', data = d)
fit
