df_sell <- read.csv('car_data/car_sell.csv')
df_search <- read.csv('car_data/car_search.csv')

library(rstan)
data <- list(Y=df_sell$ノート[1:42],
             N=length(df_sell$ノート)-12,
             N_pred=12)

fit_trend_season <- stan(file = "car_trend_season.stan",
                         data = data)

Y_pred <- extract(fit_trend_season, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$ノート[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$ノート[43:54]), type='l')

data <- list(Y=df_sell$アクア[1:42],
             N=length(df_sell$アクア)-12,
             N_pred=12)

fit_trend_season <- stan(file = "car_trend_season.stan",
                         data = data)

Y_pred <- extract(fit_trend_season, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$アクア[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$アクア[43:54]), type='l')

data <- list(Y=df_sell$プリウス[1:42],
             N=length(df_sell$プリウス)-12,
             N_pred=12)

fit_trend_season <- stan(file = "car_trend_season.stan",
                         data = data)

Y_pred <- extract(fit_trend_season, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$プリウス[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$プリウス[43:54]), type='l')


data <- list(Y=df_sell$セレナ[1:42],
             N=length(df_sell$セレナ)-12,
             N_pred=12)

fit_trend_season <- stan(file = "car_trend_season.stan",
                         data = data)

Y_pred <- extract(fit_trend_season, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$セレナ[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$セレナ[43:54]), type='l')

data <- list(Y=df_sell$フィット[1:42],
             N=length(df_sell$フィット)-12,
             N_pred=12)

fit_trend_season <- stan(file = "car_trend_season.stan",
                         data = data)

Y_pred <- extract(fit_trend_season, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$フィット[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$フィット[43:54]), type='l')

data <- list(Y=df_sell$ノート[1:42],
             X=df_search$ノート[7:48],
             N=length(df_sell$ノート)-12,
             N_pred=12)
fit_search <- stan(file = "car_search.stan",
                   data = data)
fit_search
Y_pred <- extract(fit_search, pars='Y_pred')
Y_pred_mean <- apply(data.frame(Y_pred), 2, mean)
sum((Y_pred_mean - df_sell$ノート[43:54])**2)
matplot(cbind(Y_pred_mean, df_sell$ノート[43:54]), type='l')
