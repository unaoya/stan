y <- read.table('rats.txt', header = TRUE)
x <- c(8, 15, 22, 29, 36)
xbar <- mean(x)
N <- nrow(y)
T <- ncol(y)
d <- list(N=N, T=T, x=x, y=y, xbar=xbar)
rats_fit <- stan(file = 'rats.stan', data = d)
rats_fit
