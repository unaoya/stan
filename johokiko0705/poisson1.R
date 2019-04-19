library(rstan)
d<-list(x=c(8,4,5,5,7,9,7,5,5,4), N=10)
fit2 <- stan('poisson1.stan', data=d)

fit2
stan_trace(fit2, pars='lambda')
stan_hist(fit2, pars='lambda')
stan_dens(fit2, pars='lambda', separate_chains = T)
stan_ac(fit2, pars='lambda', separate_chains = TRUE)

lambda <- rstan::extract(fit2)$lambda
lambda
mean(lambda)

#翌日事故が2件である確率
mean(dpois(x = 2, lambda = lambda))

p <- 0
for (i in 1:4000){
  p = p + dpois(x = 2, lambda = lambda[i])
}
p/4000

prob=NULL
for (i in 1:length(lambda)){
  prob[i] <- dpois(x=0, lambda=lambda[i])
}
mean(prob)

dpois(x=0, lambda=mean(lambda))
