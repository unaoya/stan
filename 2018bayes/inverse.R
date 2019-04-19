par(mfrow=c(1,2))

n <- 10000
y <- runif(n)
x <- -0.5 * log(1-y)
hist(x)

f <- function(x){2 * exp(-2 * x)}
curve(f, 0, 5)
