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
N <- 30
mu1 <- c(0.1,0)
mu2 <- c(0,0.1)
Sigma0 <- matrix(data = c(1,0,0,1), nrow = 2)
Sigma1 <- matrix(data = c(2,0,0,0.1), nrow = 2)
Sigma2 <- matrix(data = c(0.1,0,0,2), nrow = 2)

iter <- 100
results <- data.frame(waic1 = rep(0,iter),
                      wbic1 = rep(0,iter),
                      waic2 = rep(0,iter),
                      wbic2 = rep(0,iter))

for(i in 1:iter){
  d <- rng1(N, mu1, mu2, Sigma1, Sigma2)
  fit <- stan(file = 'model1.stan', data = d,
              iter = 6000, warmup = 3000)
  log_lik <- extract(fit)$log_likelihood
  results$waic1[i] <- waic(log_lik)
  results$wbic1[i] <- wbic(log_lik)
  fit2 <- stan(file = 'model2.stan', data = d,
               iter = 6000, warmup = 3000)
  log_lik <- extract(fit2)$log_likelihood
  results$waic2[i] <- waic(log_lik)
  results$wbic2[i] <- wbic(log_lik)
  print(i)
}
results
fit
fit2
stan_trace(fit2, pars = "Sigma1")
stan_trace(fit2, pars = "Sigma2")

N <- 100
iter <- 30
results100 <- data.frame(waic1 = rep(0,iter),
                      wbic1 = rep(0,iter),
                      waic2 = rep(0,iter),
                      wbic2 = rep(0,iter))

for(i in 1:iter){
  d <- rng1(N, mu1, mu2, Sigma1, Sigma2)
  fit <- stan(file = 'model1.stan', data = d,
              iter = 6000, warmup = 3000)
  log_lik <- extract(fit)$log_likelihood
  results100$waic1[i] <- waic(log_lik)
  results100$wbic1[i] <- wbic(log_lik)
  fit2 <- stan(file = 'model2.stan', data = d,
               iter = 6000, warmup = 3000)
  log_lik <- extract(fit2)$log_likelihood
  results100$waic2[i] <- waic(log_lik)
  results100$wbic2[i] <- wbic(log_lik)
  print(i)
}


select.waic <- c()
for(i in 1:50){
  select.waic[i] <- ifelse(results$waic1[i] < results$waic2[i], 1, 2)
}

select.wbic <- c()
for(i in 1:50){
  select.wbic[i] <- ifelse(results$wbic1[i] < results$wbic2[i], 1, 2)
}


library(ggplot2)
library(reshape2)
df100 <- read.csv(file = "result100.csv")
df30 <- read.csv(file = "result30.csv")

sum(df100$select.waic==1)
sum(df100$select.wbic==1)
sum(df30$select.waic==1)
sum(df30$select.wbic==1)

df.waic.30 <- data.frame(model1 = df30[,2], model2 = df30[,4], samples = as.factor(rep(30, 100)))
df.waic.100 <- data.frame(model1 = df100[,2], model2 = df100[,4], samples = as.factor(rep(100, 50)))
df.wbic.30 <- data.frame(model1 = df30[,3], model2 = df30[,5], samples = as.factor(rep(30, 100)))
df.wbic.100 <- data.frame(model1 = df100[,3], model2 = df100[,5], samples = as.factor(rep(100, 50)))
df.waic <- rbind(melt(df.waic.30), melt(df.waic.100))
df.wbic <- rbind(melt(df.wbic.30), melt(df.wbic.100))
df.wbic
g.waic <- ggplot(df.waic, aes(x = samples, y = value))
g.waic <- g.waic + geom_boxplot(aes(colour = variable))
g.waic <- g.waic + ggtitle("WAIC")
plot(g.waic)
g.wbic <- ggplot(df.wbic, aes(x = samples, y = value))
g.wbic <- g.wbic + geom_boxplot(aes(colour = variable))
g.wbic <- g.wbic + ggtitle("WBIC")
plot(g.wbic)
