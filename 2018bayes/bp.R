#データ作成
muZero <- 160
sigmaV <- 10
sigmaW <- 3
coefMedicineTrendZero <- 0.005
coefMedicineZero <- -25
sigmaWcoef <- 0.5
sigmaWcoefTrend <- 0.03
sigmaVcoef <- 2
medicine <- c(rep(0, 10), rep(1, 60), rep(2, 30), rep(3, 10))
N_Medicine <- 100
N_NotMedicine <- 10
N <- N_Medicine + N_NotMedicine
day <- 1:N
mu <- rnorm(n = 1, mean = muZero, sd = sigmaW)
for (i in 2:N){
  mu[i] <- rnorm(n = 1, mean = mu[i-1], sd = sigmaW)
}
coefMedicineTrend <- rnorm(n = 1,
                           mean = coefMedicineTrendZero,
                           sd = sigmaWcoefTrend)
for (i in 2:N_Medicine){
  coefMedicineTrend[i] <- rnorm(n = 1,
                                mean = coefMedicineTrend[i-1],
                                sd = sigmaWcoefTrend)
}
plot(coefMedicineTrend, type='b')
sum(coefMedicineTrend)
coefMedicine <- rnorm(n = 1,
                      mean = coefMedicineZero + coefMedicineTrend[1],
                      sd = sigmaWcoef)
for (i in 2:N_Medicine){
  coefMedicine[i] <- rnorm(n = 1,
                           mean = coefMedicine[i-1] + coefMedicineTrend[i],
                           sd = sigmaWcoefTrend)
}
plot(coefMedicine, type='b')
coefMedicineReal <- c()
for (i in 1:N_Medicine){
  coefMedicineReal[i] <- rnorm(n = 1,
                               mean = coefMedicine[i],
                               sd = sigmaVcoef)
}
plot(coefMedicineReal, type='b')
bloodPressure <- c()
for (i in 1:N_NotMedicine){
  bloodPressure[i] <- rnorm(n = 1, mean = mu[i], sd = sigmaV)  
}
for (i in (N_NotMedicine+1):N){
  bloodPressure[i] <- rnorm(n = 1,
                            mean = mu[i] + coefMedicineReal[i-10] * medicine[i],
                            sd = sigmaV)
}
bp <- data.frame(day, bloodPressure)
write.csv(bp, 'bp.csv')
plot(bp$bloodPressure, type="b")
abline(v=10, col="red")
abline(v=70, col="blue")
abline(v=100, col="orange")
bp

data <- list(
  N_Medicine = N_Medicine, 
  N = N,
  bloodPressure = bloodPressure,
  medicine = medicine
)

library(rstan)
fit <- stan(file = 'bp.stan', data = data)
summary(fit)
