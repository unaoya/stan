library(MASS)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

waic <- function(loglik){
  te <- -mean(log(colMeans(exp(log_lik))))
  fv <- mean(colMeans(log_lik^2) - colMeans(log_lik)^2)
  waic <- te + fv
  return(waic)
}

wbic <- function(loglik){
  wbic <- -mean(rowSums(log_lik))
  return(wbic)
}

rng1 <- function(N, mu1, mu2, Sigma1, Sigma2){
  y1 <- mvrnorm(n = 0.5 * N, mu = mu1, Sigma = Sigma1)
  y2 <- mvrnorm(n = 0.5 * N, mu = mu2, Sigma = Sigma2)
  y <- rbind(y1, y2)
  d <- list(N = N, y = y)
  return(d)
}

rng2 <- function(N, mu, Sigma0, Sigma1, Sigma2){
  y0 <- mvrnorm(n = 0.5 * N, mu = mu, Sigma = Sigma0)
  y1 <- mvrnorm(n = 0.25 * N, mu = mu, Sigma = Sigma1)
  y2 <- mvrnorm(n = 0.25 * N, mu = mu, Sigma = Sigma2)
  y <- rbind(y0, y1, y2)
  d <- list(N = N, y = y)
  return(d)
}

#真の分布のパラメータ
N <- 100
mu1 <- c(0.5,0)
mu2 <- c(0,0.5)
Sigma0 <- matrix(data = c(1,0,0,1), nrow = 2)
Sigma1 <- matrix(data = c(2,0,0,0.1), nrow = 2)
Sigma2 <- matrix(data = c(0.1,0,0,2), nrow = 2)

iter <- 2
results <- data.frame(waic1 = rep(0,iter),
                      wbic1 = rep(0,iter),
                      waic2 = rep(0,iter),
                      wbic2 = rep(0,iter))

for(i in 1:iter){
  d <- rng1(N, mu1, mu2, Sigma1, Sigma2)
  fit <- stan(file = 'model1.stan', data = d,
              iter = 5000, warmup = 1000)
  log_lik <- extract(fit)$log_likelihood
  results$waic1[i] <- waic(log_lik)
  results$wbic1[i] <- wbic(log_lik)
  fit2 <- stan(file = 'model2.stan', data = d,
               iter = 5000, warmup = 1000)
  log_lik <- extract(fit2)$log_likelihood
  results$waic2[i] <- waic(log_lik)
  results$wbic2[i] <- wbic(log_lik)
}
results
fit
fit2