//model1, クラスタ数1のモデル
data{
  int N; //サンプル数
  vector[2] y[N]; //観測値
}

parameters{
  vector[2] mu; //平均
  cov_matrix[2] Sigma; //分散
}

model{
  //事前分布
  for(i in 1:2){
    mu[i] ~ normal(0,1);
  }
  //負の対数尤度
  for(n in 1:N){
    target += -log(determinant(Sigma)) - 0.5 * (y[n] - mu)' * inverse(Sigma) * (y[n] - mu); //定数は省略
  }
}

generated quantities{
  vector[N] log_likelihood;
  for(n in 1:N){
    log_likelihood[n] = -log(determinant(Sigma)) - 0.5 * (y[n] - mu)' * inverse(Sigma) * (y[n] - mu);
  }
}
