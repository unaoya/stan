bp <- read.csv('data/bp.csv')
bp <- bp[,-1]
bp
plot(bp$bloodPressure, type="b")
abline(v=10, col="red")
abline(v=70, col="blue")
abline(v=100, col="orange")
bp

medicine <- c(rep(0, 10), rep(1, 60), rep(2, 30), rep(3, 10))
N_Medicine <- 100
N_NotMedicine <- 10
N <- N_Medicine + N_NotMedicine

data <- list(
  N_Medicine = N_Medicine, 
  N = N,
  bloodPressure = bp$bloodPressure,
  medicine = medicine
)

library(rstan)
fit <- stan(file = 'bp.stan', data = data)
fit
summary(fit)$summary[,'Rhat']

summary(fit)$summary['muZero',]
summary(fit)$summary['sigmaV',]
summary(fit)$summary['sigmaW',]
summary(fit)$summary['coefMedicineTrendZero',]
summary(fit)$summary['coefMedicineZero',]
summary(fit)$summary['sigmaWcoef',]
summary(fit)$summary['sigmaWcoefTrend',]
summary(fit)$summary['sigmaVcoef',]

mu <- rstan::extract(fit, pars='mu')
mu_mean <- apply(X = mu[[1]], FUN = mean, MARGIN = 2)

coefMedicineReal <- rstan::extract(fit, pars='coefMedicineReal')
coef_mean <- apply(X = coefMedicineReal[[1]], FUN = mean, MARGIN = 2)
coef_mean <- c(rep(0,10), coef_mean)

bloodpressure <- mu_mean + medicine * coef_mean
res <- data.frame(bloodpressure, bp$bloodPressure)
matplot(res, type = 'l')

plot(coef_mean, type='l')
