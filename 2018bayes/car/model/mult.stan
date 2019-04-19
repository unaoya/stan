data {
  int N; //学習期間の長さ
  int N_pred; //予測期間の長さ
  vector[N] Y; //販売台数データ
  vector[N] X; //検索量データ
}

parameters {
  vector[N] alpha_X; //検索量の状態トレンド成分
  vector[N] season_X; //検索量の状態季節成分
  vector[N] alpha_Y; //販売台数の状態トレンド成分
  vector[N] season_Y; //販売台数の状態季節成分
  real<lower=0> s_X; //検索量の観測誤差の分散
  real<lower=0> s_Y; //販売台数の観測誤差の分散
  real<lower=0> s_a_X; //検索量の状態トレンドの分散
  real<lower=0> s_season_X; //検索量の季節成分の分散
  real<lower=0> s_a_Y; //販売台数の状態トレンドの分散
  real<lower=0> s_season_Y; //販売台数の季節成分の分散
  vector[3] b; //販売台数に対する検索量のトレンドの重み
}

transformed parameters {
  vector[N] x_mean;
  vector[N] y_mean;
  x_mean = alpha_X + season_X;
  y_mean = alpha_Y + season_Y;
}

model {
  alpha_X[3:N] ~ normal(2*alpha_X[2:(N-1)] - alpha_X[1:(N-2)], s_a_X); //検索量トレンドの状態モデル
  for(t in 12:N){
    season_X[t] ~ normal(-sum(season_X[(t-11):(t-1)]), s_season_X); //検索量季節成分
  }
  X ~ normal(x_mean, s_X); //検索量の観測モデル
  alpha_Y[3:N] ~ normal(2*alpha_Y[2:(N-1)] - alpha_Y[1:(N-2)], s_a_Y); //販売台数トレンドの状態モデル
  for(t in 12:N){
    season_Y[t] ~ normal(-sum(season_Y[(t-11):(t-1)]), s_season_Y); //販売台数季節成分
  }
  // 以下が違う
  Y[1] ~ normal(y_mean[1], s_Y);
  Y[2] ~ normal(y_mean[2], s_Y);
  Y[3:N] ~ normal(y_mean[3:N] + b[1] * alpha_X[3:N] + b[2] * alpha_X[2:(N-1)] + b[3] * alpha_X[1:(N-2)], s_Y); //販売台数の観測モデル
}

generated quantities {
  vector[N+N_pred] alpha_X_all;
  vector[N+N_pred] season_X_all;
  vector[N+N_pred] alpha_Y_all;
  vector[N+N_pred] season_Y_all;
  vector[N+N_pred] X_all;
  vector[N+N_pred] Y_all;
  alpha_X_all[1:N] = alpha_X;
  season_X_all[1:N] = season_X;
  alpha_Y_all[1:N] = alpha_Y;
  season_Y_all[1:N] = season_Y;
  X_all[1:N] = x_mean;
  Y_all[1:N] = y_mean;
  for (t in 1:N_pred) {
    season_X_all[N+t] = normal_rng(-sum(season_X_all[(N+t-11):(N+t-1)]), s_season_X);
    alpha_X_all[N+t] = normal_rng(2*alpha_X_all[N+t-1] - alpha_X_all[N+t-2], s_a_X);
    X_all[N+t] = normal_rng(alpha_X_all[N+t]+season_X_all[t], s_X);
  }
  for (t in 1:N_pred) {
    season_Y_all[N+t] = normal_rng(-sum(season_Y_all[(N+t-11):(N+t-1)]), s_season_Y);
    alpha_Y_all[N+t] = normal_rng(2*alpha_Y_all[N+t-1] - alpha_Y_all[N+t-2], s_a_Y);
    Y_all[t+N] = normal_rng(alpha_Y_all[N+t]+season_Y_all[t]+b[1]*X_all[N+t]+b[2]*X_all[N+t-1]+b[3]*X_all[N+t-2], s_Y); //ここも違う
  }
}
