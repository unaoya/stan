set.seed(123)

d <- rbinom(n=10000, size=5, prob=0.75)
d

summary(as.factor(d))
