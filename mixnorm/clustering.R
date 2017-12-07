library(MASS)
library(rstan)

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

#真の分布のパラメータ
N <- 100
mu <- c(0,0)
Sigma0 <- matrix(data = c(1,0,0,1), nrow = 2)
Sigma1 <- matrix(data = c(1,0,0,0.1), nrow = 2)
Sigma2 <- matrix(data = c(0.1,0,0,1), nrow = 2)

rng1 <- function(N, mu, Sigma1, Sigma2){
  y1 <- mvrnorm(n = 0.5 * N, mu = mu, Sigma = Sigma1)
  y2 <- mvrnorm(n = 0.5 * N, mu = mu, Sigma = Sigma2)
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

results <- data.frame(waic1 = c(), wbic1 = c(), waic2 = c(), wbic2 = c())

iter <- 5
for(i in 1:iter){
  d <- rng1(N, mu1, mu2, Sigma)
  fit <- stan(file = 'mixnorm1.stan', data = d)
  log_lik <- extract(fit)$log_likelihood
  results$waic1[i] <- waic(log_lik)
  results$wbic1[i] <- wbic(log_lik)
  fit2 <- stan(file = 'mixnorm2.stan', data = d)
  log_lik <- extract(fit2)$log_likelihood
  results$waic2[i] <- waic(log_lik)
  results$wbic2[i] <- wbic(log_lik)
}
