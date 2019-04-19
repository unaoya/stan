data{
  int T; //サンプルサイズ
  vector[T] Y; //観測値
}

parameters{
  vector[T] mu; //トレンド項
  vector[T] season; //季節調整項
  real<lower=0> s_mu; //トレンドの分散
  real<lower=0> s_season; //季節調整項の誤差
  real<lower=0> s_Y; //観測誤差
}

transformed parameters{
  vector[T] y_mean;
  y_mean = mu + season;
}

model{
  mu[2:T] ~ normal(mu[1:(T-1)], s_mu);
  for(t in 4:T){
    season[t] ~ normal(-sum(season[(t-3):(t-1)]), s_season);
  }
  Y ~ normal(y_mean, s_Y);
}
