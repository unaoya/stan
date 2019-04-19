df <- read.csv('data-ss2.txt')
plot(df$Y, type='b')
d <- list(T = length(df$Y), Y = df$Y)

library(rstan)
fit <- stan(file = "season.stan", data = d)

upr <- summary(fit)$summary[92:135,4]
mean <- summary(fit)$summary[92:135,1]
lwr <- summary(fit)$summary[92:135,8]
res <- data.frame(df$Y, mean, upr, lwr)
matplot(res, type="l", lty=1:4, col=1:4)
legend("topright", c("observe", "state", "95%upr", "95%lwr"),
       lty=1:4, col=1:4)


df <- read.csv('data_changepoint.txt')
plot(df$Y, type='l')
d <- list(T = length(df$Y), Y = df$Y)
library(rstan)
fit <- stan(file = 'changept.stan', data = d)
rownames(summary(fit)$summary)
upr <- summary(fit)$summary[403:802,4]
mean <- summary(fit)$summary[403:802,1]
lwr <- summary(fit)$summary[403:802,8]
res <- data.frame(df$Y, mean, upr, lwr)
matplot(res, type="l", lty=1:4, col=1:4)
legend("topright", c("observe", "state", "95%upr", "95%lwr"),
       lty=1:4, col=1:4)