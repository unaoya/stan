data{
  int N; //県の数
  real height1[N]; //1年目の平均
  real height2[N]; //2年目の平均
  int X[N]; //給食タイプ
  int N_beta; //係数の数
  real sd1[N]; //1年目の標準偏差
  real sd2[N]; //2年目の標準偏差
}

parameters{
  real beta[N_beta];
  real<lower=0> sigma1;
  real<lower=0> sigma2;
  real r1[N];
  real r2[N];
}

transformed parameters{
  real mu1[N];
  real mu2[N];
  for(i in 1:N){
    mu1[i] = beta[1] + r1[i];
    mu2[i] = beta[1] + r1[i] + beta[2] + r2[i] + beta[3] * X[i];
  }
}

model{
  for(i in 1:N){
    height1[i] ~ normal(mu1[i], sd1[i]);
    height2[i] ~ normal(mu2[i], sd2[i]);
  }
  for(i in 1:N_beta){
    beta[i] ~ uniform(-1.0e+4, 1.0e+4);
  }
  for(i in 1:N){
    r1[i] ~ normal(0, sigma1);
    r2[i] ~ normal(0, sigma2);
  }
  sigma1 ~ uniform(0, 1.0e+4);
  sigma2 ~ uniform(0, 1.0e+4);
}
