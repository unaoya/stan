data{
  int N; //サンプル数
  vector[2] y[N]; //観測値
}

parameters{
  vector[2] mu1; //クラスタ1の平均
  cov_matrix[2] Sigma1; //クラスタ1の分散
  vector[2] mu2; //クラスタ2の平均
  cov_matrix[2] Sigma2; //クラスタ2の分散
}

transformed parameters{
  real<upper=0> soft_z[N, 2]; // log unnormalized clusters
  for(n in 1:N){
    soft_z[n, 1] = -log(2) - log(determinant(Sigma1)) - 0.5 * (y[n] - mu1)' * inverse(Sigma1) * (y[n] - mu1); //定数は省略
    soft_z[n, 2] = -log(2) - log(determinant(Sigma2)) - 0.5 * (y[n] - mu2)' * inverse(Sigma2) * (y[n] - mu2); //定数は省略
  }
}
 
model{
  //事前分布
  for(i in 1:2){
    mu1[i] ~ normal(0,1);
  }
  for(i in 1:2){
    mu2[i] ~ normal(0,1);
  }
  //負の対数尤度
  for(n in 1:N){
    target += log_sum_exp(soft_z[n]);
  }
}

generated quantities{
  vector[N] log_likelihood;
  for(n in 1:N){
    log_likelihood[n] = log_sum_exp(soft_z[n]);
  }
}
