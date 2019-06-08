set.seed(111)

theta <- runif(1)

n <- 100
x <- rbinom(n=1, size=n, prob=theta)
x

f <- function(p){choose(n,x) * p^x * (1-p)^(n-x)}
plot(f, 0, 1)

theta
