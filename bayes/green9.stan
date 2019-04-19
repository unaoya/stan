data{
  int N; //サンプルサイズ
  int y[N]; //種子数
  real x[N]; //サイズ
}

parameters{
  real beta1;
  real beta2;
}
transformed parameters{
  vector[N] lambda; //平均
  for(n in 1:N)
    lambda[n]=exp(x[n]*beta2+beta1);
}

model{
  y ~ poisson(lambda);
  beta1 ~ normal(0,100); //無情報事前分布の代わり 
  beta2 ~ normal(0,100); //無情報事前分布の代わり
}
