data{
  int N; //サンプルサイズ
  real y[N]; //製品の大きさ
}

parameters{
  real mu; //平均
  real<lower=0> sigma; //標準偏差
}

model{
  mu ~ normal(0,100); //事前分布      
  sigma ~ cauchy(0,5); //事前分布
  y ~ normal(mu, sigma); //正規分布モデル
}
