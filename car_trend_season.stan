data {
  int N;
  int N_pred;
  vector[N] Y;
}

parameters {
  vector[N] alpha;
  vector[N] season;
  real<lower=0> s_Y;
  real<lower=0> s_a;
  real<lower=0> s_season;
}

transformed parameters {
  vector[N] y_mean;
  y_mean = alpha + season;
}

model {
  alpha[3:N] ~ normal(2*alpha[2:(N-1)] - alpha[1:(N-2)], s_a);
  for(t in 12:N){
    season[t] ~ normal(-sum(season[(t-11):(t-1)]), s_season);
  }
  Y ~ normal(y_mean, s_Y);
}

generated quantities {
  vector[N+N_pred] alpha_all;
  vector[N+N_pred] season_all;
  vector[N_pred] Y_pred;
  alpha_all[1:N] = alpha;
  season_all[1:N] = season;
  for (t in 1:N_pred) {
    season_all[N+t] = normal_rng(-sum(season_all[(N+t-11):(N+t-1)]), s_season);
    alpha_all[N+t] = normal_rng(2*alpha_all[N+t-1] - alpha_all[N+t-2], s_a);
    Y_pred[t] = normal_rng(alpha_all[N+t]+season_all[t], s_Y);
  }
}
