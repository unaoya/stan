X <- 1961:1990
Y <- c(4.71, 7.70, 7.97, 8.35, 5.70,
       7.33, 3.10, 4.98, 3.75, 3.35,
       1.84, 3.28, 2.77, 2.72, 2.54,
       3.23, 2.45, 1.90, 2.56, 2.12,
       1.78, 3.18, 2.64, 1.86, 1.69,
       0.81, 1.02, 1.40, 1.31, 1.57)
data <- list(N=length(X), Y=Y)
plot.new()
par(new=F)
plot(Y~X, type="l")


library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
##ローカルレベルモデル
localLevelModel <- '
data {
  int<lower=0> N;
  real<lower=0> Y[N];
}
parameters {
  real alpha[N];
  real<lower=0> s_Y;
  real<lower=0> s_a;
}
model {
  for(i in 1:N)
    Y[i] ~ normal(alpha[i], s_Y);
  for(i in 2:N)
    alpha[i] ~ normal(alpha[i-1], s_a);
}
'

#MCMC
fit <- stan(model_code = localLevelModel, data=data,
            iter=1700, warmup=200, thin=3, seed=1)
fit
stan_trace(fit)

#パラメータの取り出し
alpha <- get_posterior_mean(fit, par='alpha')[,'mean-all chains']
s_Y <- get_posterior_mean(fit, par ='s_Y')[,'mean-all chains']
s_a <- get_posterior_mean(fit, par ='s_a')[,'mean-all chains']
upr <- summary(fit)$summary[1:30,4]
lwr <- summary(fit)$summary[1:30,8]
mean(upr - lwr)
?stan

#信頼上限下限
upr <- alpha + 1.96*summary(fit)$summary[1:30,4]
lwr <- alpha - 1.96*summary(fit)$summary[1:30,8]
#描画
res <- data.frame(Y, alpha, upr, lwr)
matplot(res, type="l", lty=1:4, col=1:4)
legend("topright", c("observe", "state", "95%upr", "95%lwr"),
       lty=1:4, col=1:4)

##トレンドモデル
trendModel <- '
data {
  int<lower=0> N;
  real<lower=0> Y[N];
}
parameters {
  real alpha[N];
  real<lower=0> s_Y;
  real<lower=0> s_a;
}
model {
  for(i in 1:N)
    Y[i] ~ normal(alpha[i], s_Y);
  for(i in 3:N)
    alpha[i] ~ normal(2*alpha[i-1] - alpha[i-2], s_a);
}
'

#MCMC
stantrend <- stan_model(model_code=trendModel)
fit_trend <- sampling(stantrend, data=data, iter=3000, warmup=500, thin=3, seed=1)
fit_trend
traceplot(fit_trend, pars="alpha")
traceplot(fit_trend, pars=c("s_Y", "s_a"))
#パラメータの取り出し
alpha <- get_posterior_mean(fit_trend, par = 'alpha')[, 'mean-all chains']
s_Y <- get_posterior_mean(fit_trend, par = 's_Y')[, 'mean-all chains']
s_a <- get_posterior_mean(fit_trend, par = 's_a')[, 'mean-all chains']
#信頼上限下限
upr <- summary(fit_trend)$summary[1:30,4]
lwr <- summary(fit_trend)$summary[1:30,8]
mean(upr - lwr)

summary(fit_trend)$summary
fit_trend
#描画
res <- data.frame(Y, alpha, upr, lwr)
matplot(res, type="l", lty=1:4, col=1:4)
legend("topright", c("observe", "state", "95%upr", "95%lwr"), lty=1:4, col=1:4)

curve(dlnorm, -1, 4, type = 'l')


#観測誤差に対数正規分布を仮定
trendModelLN <- '
data {
  int<lower=0> N;
  real<lower=0> Y[N];
}
parameters {
  real alpha[N];
  real<lower=0> s_Y;
  real<lower=0> s_a;
}
model {
  for(i in 1:N)
    Y[i] ~ lognormal(alpha[i], s_Y);
  for(i in 3:N)
    alpha[i] ~ normal(2*alpha[i-1] - alpha[i-2], s_a);
}
'

#MCMC
stantrendLN <- stan_model(model_code=trendModelLN)
fit_trendLN <- sampling(stantrendLN, data=data, iter=5000, warmup=2000, thin=5)
fit_trendLN
rstan::traceplot(fit_trendLN, pars="alpha")
rstan::traceplot(fit_trendLN, pars=c("s_Y", "s_a"))

#パラメータの取り出し
alpha <- get_posterior_mean(fit_trendLN, par = 'alpha')[, 'mean-all chains']
s_Y <- get_posterior_mean(fit_trendLN, par = 's_Y')[, 'mean-all chains']
s_a <- get_posterior_mean(fit_trendLN, par = 's_a')[, 'mean-all chains']
#信頼上限下限

upr <- summary(fit_trendLN)$summary[1:30,4]
lwr <- summary(fit_trendLN)$summary[1:30,8]
#描画
res <- data.frame(Y, exp(alpha), exp(upr), exp(lwr))
matplot(res, type="l", lty=1:4, col=1:4)
legend("topright", c("observe", "state","95%upr", "95%lwr"),
       lty=1:4, col=1:4) 

yy