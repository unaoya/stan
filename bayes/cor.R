library(MASS)
mu <- c(0,0)
Sigma <- matrix(c(1.0,0.7,0.7,1),2,2)
N <- 25
y <- mvrnorm(N,mu,Sigma)
plot(y)
cor(y)
d <- list(N=N,y=y)
fit <- stan(file = "cor.stan", data = d)
fit
rho <- rstan::extract(fit)$rho
plot(density(rho))
