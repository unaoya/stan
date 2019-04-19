y <- rnorm(100,5,2)
d <- list(y=y,N=length(y))
fit <- stan(file = "normal1.stan", data = d)
fit
