df <- data.frame(team=c(rep(1,3),rep(2,3),rep(3,3)), score=c(3,2,5,3,1,3,2,0,1))
d <- list(N = 9, M = 3, X = df$score, team = df$team)
d
library(rstan)
fit <- stan(file = "poisson.stan", data=d, iter = 10000)
fit
