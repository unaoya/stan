#松浦12章季節調整
df <- read.csv('data-ss2.txt')
df
plot(df$Y, type='b')
d <- list(T = length(df$Y), Y = df$Y)

library(rstan)
fit <- stan(file = "season.stan", data = d)
fit
