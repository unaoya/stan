data{
  int N; //サンプル数
  vector[2] y[N]; //観測値
}

transformed data{
  vector[2] mu1;
  vector[2] mu2;
  for(i in 1:2){
    mu1[i] = 0.0;
  }
  for(i in 1:2){
    mu2[i] = 0.0;
  }
}

parameters{
  corr_matrix[2] Omega1;
  corr_matrix[2] Omega2;
  vector<lower=0>[2] tau1;
  vector<lower=0>[2] tau2;
}

transformed parameters{
  cov_matrix[2] Sigma1 = quad_form_diag(Omega1, tau1);
  cov_matrix[2] Sigma2 = quad_form_diag(Omega2, tau2);
  real<upper=0> soft_z[N, 2]; // log unnormalized clusters
  for(n in 1:N){
    soft_z[n, 1] = -log(2) - log(determinant(Sigma1)) - 0.5 * (y[n] - mu1)' * inverse(Sigma1) * (y[n] - mu1); //定数は省略
    soft_z[n, 2] = -log(2) - log(determinant(Sigma2)) - 0.5 * (y[n] - mu2)' * inverse(Sigma2) * (y[n] - mu2); //定数は省略
  }
}
 
model{
  //分散の事前分布
  tau1 ~ cauchy(0, 2.5);
  tau2 ~ cauchy(0, 2.5);
  Omega1 ~ lkj_corr(1);
  Omega2 ~ lkj_corr(1);

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
