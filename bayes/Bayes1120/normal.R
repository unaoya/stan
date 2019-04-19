pnorm(-1,mean=0,sd=1)
#mu=0, sigma=1の正規分布で
#-1以下になる確率を計算
library(rstan)
y <- c(102.3, 100.4, 99.3,
       100.2, 100.3, 99.4,
       101.5, 99.3, 98.9, 100.1)
d <- list(y=y, N=length(y))
fit3 <- stan(file='normal.stan',data=d)
fit3
stan_trace(fit3, pars='mu')
stan_hist(fit3, pars='mu')
stan_dens(fit3, pars='mu')
stan_ac(fit3, pars='mu', separate_chains = TRUE)

mu <- rstan::extract(fit3)$mu
sigma <- rstan::extract(fit3)$sigma
p <- 0
for(i in 1:4000){
  p <- p + mean(pnorm(100,mean=mu,sd=sigma[i]))
}
p/4000
