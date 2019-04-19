data{
  int D;  //成功した回数
  int N;  //試行回数
}
  
parameters{
  real<lower=0,upper=1> p;  //成功確率
}

model{
  D ~ binomial(N,p);  //二項分布モデル
}
