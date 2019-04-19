library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
#データの読み込み (8 個中の生存種子数:y)
d <- read.csv(url("http://hosho.ees.hokudai.ac.jp/~kubo/stat/iwanamibook/fig/hbm/data7a.csv"))
head(d)
str(d)

hist(d$y)
sum(d$y)
p <- mean(d$y)/8
8*p*(1-p)
var(d$y)

#データをリスト型に
dat<-list(N=nrow(d),y=d$y)
#MCMC
fit.hieral <- stan(file = 'seed.stan',
                    data=dat, iter=3000, warmup=1000)
fit.hieral
#トレースプロット
rstan::traceplot(fit.hieral, pars="beta")
rstan::traceplot(fit.hieral, pars="s")
#パラメータの取得
beta <- get_posterior_mean(fit.hieral, par = 'beta')[, 'mean-all chains']
s <- get_posterior_mean(fit.hieral, par = 's')[, 'mean-all chains']
r <- get_posterior_mean(fit.hieral, par = 'r')[, 'mean-all chains']
q <- get_posterior_mean(fit.hieral, par = 'q')[, 'mean-all chains']
beta
s
r
q

stan_hist(fit.hieral, pars='beta')
stan_hist(fit.hieral, pars='s')
stan_hist(fit.hieral, pars='r')
stan_hist(fit.hieral, pars='q')

#ヒストグラム (うまく表現できている気がする!)
hist(q*8)
