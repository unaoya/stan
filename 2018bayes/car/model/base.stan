data {
  int N; //学習期間の長さ
  int N_pred; //予測期間の長さ
  vector[N] Y; //販売台数データ
}

parameters {
  vector[N] alpha; //状態のトレンド成分
  vector[N] season; //状態の季節成分
  real<lower=0> s_Y; //観測誤差の分散
  real<lower=0> s_a; //トレンド成分の分散
  real<lower=0> s_season; //季節成分の分散
}

transformed parameters {
  vector[N] y_mean;
  y_mean = alpha + season;
}

model {
  alpha[3:N] ~ normal(2*alpha[2:(N-1)] - alpha[1:(N-2)], s_a); //状態モデル
  for(t in 12:N){
    season[t] ~ normal(-sum(season[(t-11):(t-1)]), s_season); //季節成分
  }
  Y ~ normal(y_mean, s_Y); //観測モデル
}

generated quantities {
  vector[N+N_pred] alpha_all;
  vector[N+N_pred] season_all;
  vector[N+N_pred] Y_all;
  alpha_all[1:N] = alpha;
  season_all[1:N] = season;
  Y_all[1:N] = y_mean;
  for (t in 1:N_pred) {
    season_all[N+t] = normal_rng(-sum(season_all[(N+t-11):(N+t-1)]), s_season);
    alpha_all[N+t] = normal_rng(2*alpha_all[N+t-1] - alpha_all[N+t-2], s_a);
    Y_all[N+t] = normal_rng(alpha_all[N+t]+season_all[t], s_Y);
  }
}
