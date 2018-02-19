library(MASS)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

rng <- function(N, Sigma1, Sigma2){
  y1 <- mvrnorm(n = 0.5 * N, mu = c(0,0), Sigma = Sigma1)
  y2 <- mvrnorm(n = 0.5 * N, mu = c(0,0), Sigma = Sigma2)
  y <- rbind(y1, y2)
  d <- list(N = N, y = y)
  return(d)
}

N <- 30
Sigma1 <- matrix(data = c(1,0,0,0.1), nrow = 2)
Sigma2 <- matrix(data = c(0.1,0,0,1), nrow = 2)

d <- rng (N, Sigma1, Sigma2)
plot(d$y)
fit <- stan(file = "mult_norm.stan", data = d, iter = 10000)
fit
stan_trace(fit, pars = "Omega1")
