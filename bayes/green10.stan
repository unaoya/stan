data{
  int N; //サンプル数
  int y[N];  //生存種子数
}

parameters{
  real beta;  //生存確率の大域的パラメータ
  real<lower=0> s;  //個体差の分散
  real r[N];  //個体差
}

transformed parameters{
  real q[N];  //生存確率
  for(i in 1:N){
    q[i] = inv_logit(beta+r[i]);
  }
}

model{
  for(i in 1:N){
    r[i] ~ normal(0,s);
  }
  s ~ cauchy(0,5);
  beta ~ normal(0,100);
  for(i in 1:N){
    y[i] ~ binomial(8,q[i]);
  }
}
