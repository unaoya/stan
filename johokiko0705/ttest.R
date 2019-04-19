N<-10
y<-c(60,39,75,64,36,45,38,28,3,9)
x<-c(73,67,19,100,100,0,58,39,84,62)
d<-list(N=N, x=x, y=y)
fit <- stan(file = "ttest.stan", data = d)
fit
stan_dens(fit, separate_chains = T)
stan_ac(fit, separate_chains = T)

stan_hist(fit, pars = c("mu_x", "mu_y", "diff"))
diff <- rstan::extract(fit)$diff
p <- sum(ifelse(diff>0, 1, 0))/length(diff)
p
