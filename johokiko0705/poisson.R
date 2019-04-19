N <- 10000
lambda <- 2
x <-rpois(n = N, lambda = lambda)
hist(x, breaks=0:max(x))

lambda <- 3
x <-rpois(n = N, lambda = lambda)
hist(x, breaks=0:max(x))

lambda <- 4
x <-rpois(n = N, lambda = lambda)
hist(x, breaks=0:max(x))

lambda <- 5
x <-rpois(n = N, lambda = lambda)
hist(x, breaks=0:max(x))
