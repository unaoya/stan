d <- read.table(file = "../RStanBook/chap08/input/data-salary-2.txt",
                sep = ",",
                header = TRUE)
str(d)
summary(d)
head(d)
d$KID <- as.factor(d$KID)
library(ggplot2)
g <- ggplot(aes(x=X, y=Y), data = d)
g + geom_point(aes(color=KID))

library(rstan)
data <- list(X=d$X, Y=d$Y, N=length(d$X))
fit <- stan(file = "model8-1.stan", data = data)
fit
a <- mean(rstan::extract(fit)$a)
b <- mean(rstan::extract(fit)$b)
g <- ggplot(aes(x=X, y=Y), data = d)
g + geom_point(aes(color=KID)) +
  geom_abline(slope = b, intercept = a)
