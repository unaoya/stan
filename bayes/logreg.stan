data{
  int N;  //サンプル数
  int M;  //テスト問題数
  int x[N]; //正解数
}

parameters{
  real<lower=0> sigma; //個人差の分散
  real r[N];  //個人差
  real beta;  //共通パラメータ
}

transformed parameters{
  real<lower=0,upper=1> p[N]; //個人の正解率
  for (i in 1:N){
    p[i] = inv_logit(beta+r[i]);
  }
}

model{
  for (i in 1:N){
    r[i] ~ normal(0,sigma);
  }
  for (i in 1:N){
    x[i] ~ binomial(M,p[i]);
  }
}
