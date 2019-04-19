N <- 10
y <- c(60,39,75,64,36,45,38,28,3,9)
x <- c(73,67,19,100,100,0,58,39,84,62)
mean(y)
mean(x)
d <- list(N=N, x=x, y=y)
fit <- stan(file='ttest.stan', data=d)
fit
diff <- rstan::extract(fit)$diff
p <- mean(ifelse(diff>0,1,0))
p
plot(density(diff))
stan_trace(fit)
stan_hist(fit,pars=c('mu_x','mu_y'))
