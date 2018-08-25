data {
  int N;
  int N_pred;
  vector[N] Y;
  vector[N] X;
}

parameters {
  vector[N] alpha_X;
  vector[N] season_X;
  vector[N] alpha_Y;
  vector[N] season_Y;
  real<lower=0> s_X;
  real<lower=0> s_Y;
  real<lower=0> s_a_X;
  real<lower=0> s_season_X;
  real<lower=0> s_a_Y;
  real<lower=0> s_season_Y;
  real b;
}

transformed parameters {
  vector[N] x_mean;
  vector[N] y_mean;
  x_mean = alpha_X + season_X;
  y_mean = alpha_Y + season_Y;
}

model {
  alpha_X[3:N] ~ normal(2*alpha_X[2:(N-1)] - alpha_X[1:(N-2)], s_a_X);
  for(t in 12:N){
    season_X[t] ~ normal(-sum(season_X[(t-11):(t-1)]), s_season_X);
  }
  X ~ normal(x_mean, s_X);
  alpha_Y[3:N] ~ normal(2*alpha_Y[2:(N-1)] - alpha_Y[1:(N-2)], s_a_Y);
  for(t in 12:N){
    season_Y[t] ~ normal(-sum(season_Y[(t-11):(t-1)]), s_season_Y);
  }
  Y ~ normal(y_mean + b * X, s_Y);
}

generated quantities {
  vector[N+N_pred] alpha_X_all;
  vector[N+N_pred] season_X_all;
  vector[N+N_pred] alpha_Y_all;
  vector[N+N_pred] season_Y_all;
  vector[N_pred] X_pred;
  vector[N_pred] Y_pred;
  alpha_X_all[1:N] = alpha_X;
  season_X_all[1:N] = season_X;
  alpha_Y_all[1:N] = alpha_Y;
  season_Y_all[1:N] = season_Y;
  for (t in 1:N_pred) {
    season_X_all[N+t] = normal_rng(-sum(season_X_all[(N+t-11):(N+t-1)]), s_season_X);
    alpha_X_all[N+t] = normal_rng(2*alpha_X_all[N+t-1] - alpha_X_all[N+t-2], s_a_X);
    X_pred[t] = normal_rng(alpha_X_all[N+t]+season_X_all[t], s_X);
  }
  for (t in 1:N_pred) {
    season_Y_all[N+t] = normal_rng(-sum(season_Y_all[(N+t-11):(N+t-1)]), s_season_Y);
    alpha_Y_all[N+t] = normal_rng(2*alpha_Y_all[N+t-1] - alpha_Y_all[N+t-2], s_a_Y);
    Y_pred[t] = normal_rng(alpha_Y_all[N+t]+season_Y_all[t]+b*X[t], s_Y);
  }
}
