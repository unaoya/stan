data{
  int N;  //サンプル数
  real y[N];  //群1
  real x[N];  //群2
}

parameters{
  real mu_y;  //yの平均値
  real<lower=0> sigma_y;  //yの標準偏差
  real mu_x;  //xの平均値
  real<lower=0> sigma_x;  //xの標準偏差
}

model{
  mu_y ~ normal(0,100); //無情報事前分布
  sigma_y ~ cauchy(0,5);//無情報事前分布
  mu_x ~ normal(0,100); //無情報事前分布
  sigma_x ~ cauchy(0,5);//無情報事前分布
  
  y ~ normal(mu_y,sigma_y);
  x ~ normal(mu_x,sigma_x);
}

generated quantities{
  real diff;  //2群の平均の差
  diff = mu_x-mu_y;
}
