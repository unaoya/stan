N <- 30
M <- 4
x1 <- rep(1,30)
x2 <- runif(N)
x3 <- runif(N)
x4 <- runif(N)
matrix(data=c(x1,x2,x3,x4),nrow=4,ncol=30)
noise <- rnorm(N, mean=0, sd=0.1)
a <- c(1,2,3,4)
y <- b + a*x + noise
plot(x,y)

d <- list(x=x, y=y, N=N)
fit <- stan(file='linreg.stan',data=d)
fit
