#松浦12章変化点
df <- read.csv('data_changepoint.txt')
df
d <- list(T = length(df$Y), Y = df$Y)
library(rstan)
fit <- stan(file = 'changept.stan', data = d)

fit1 <- stan(file = 'changepoint-1.stan', data = d)
