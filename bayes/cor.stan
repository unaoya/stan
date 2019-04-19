data{
  int N;  //サンプル数
  vector[2] y[N]; //観測値二変数をベクトルでまとめる
}

parameters{
  vector[2] mu; //平均
  vector<lower=0>[2] sigma; //標準偏差
  real<lower=-1,upper=1> rho; //相関係数
}

transformed parameters{
  cov_matrix[2] Sig;  //共分散行列
  Sig[1,1] = sigma[1]^2;
  Sig[2,2] = sigma[2]^2;
  Sig[1,2] = rho*sigma[1]*sigma[2];
  Sig[2,1] = rho*sigma[1]*sigma[2];
}

model{
  mu ~ normal(0,100);
  sigma ~ cauchy(0,5);
  rho ~ uniform(-1,1);
  y ~ multi_normal(mu,Sig);
}
