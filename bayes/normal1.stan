data{
  int N;      //サンプル数
  real y[N];  //観測値
}

parameters{
  real mu;    //平均
  real<lower=0> sigma; //標準偏差
}

model{
  mu ~ normal(0,100);   //平均の事前分布
  sigma ~ cauchy(0,5);  //標準偏差の事前分布
  for(i in 1:N){
    y[i] ~ normal(mu,sigma);
  }
}
