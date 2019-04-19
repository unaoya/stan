data{
  int N;  //サンプル数
  real x[N];  //説明変数
  real y[N];  //目的変数
}
parameters{
  real a; //傾き
  real b; //切片
  real<lower=0> sigma;  //誤差の標準偏差
}
model{
  for (i in 1:N){
    y[i] ~ normal(b+a*x[i],sigma);
  }
}
