library(rstan)

N <- 100
X <- rnorm(n = N)
plot(X, type='l')
N_train <- 90
X_train <- X[1:N_train]
X_test <- X[N_train+1:N]
d <- list(N_train = N_train,
          N_test = N - N_train,
          X_train <- X_train)

fit <- stan(file = "cv.stan", data = d)
alpha_all <- extract(fit, pars='alpha_all')
alpha_all_mean <- apply(data.frame(alpha_all), 2, mean)
X_pred <- extract(fit, pars='X_pred')
X_pred_mean <- apply(data.frame(X_pred), 2, mean)
sum((X_pred_mean - X[91:100])**2)
matplot(cbind(X, alpha_all_mean), type='l')
