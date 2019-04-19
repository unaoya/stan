y <- c(102.3,100.4,99.3,100.2,100.3,99.4,101.5,99.3,98.9,100.1)
d <- list(y=y,N=length(y))
fit3 <- stan(file = "normal1.stan", data = d)
fit3
stan_trace(fit3, pars = c("mu", "sigma"))
stan_hist(fit3, pars = c("mu", "sigma"))
stan_dens(fit3, pars = c("mu", "sigma"), separate_chains = T)
stan_ac(fit3, pars = c("mu", "sigma"), separate_chains = T)

# サンプルの抽出
mu <- rstan::extract(fit3)$mu
sigma <- rstan::extract(fit3)$sigma
# 次の製品が101以下である確率を予測
mean(pnorm(101, mean=mu, sd=sigma))
# 次の製品が99以上101以下である確率を予測
mean(pnorm(101, mean=mu, sd=sigma) -
       pnorm(99, mean=mu, sd=sigma))

