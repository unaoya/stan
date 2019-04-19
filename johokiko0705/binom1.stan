data{
  int D; //表の出る回数
  int N; //投げた回数
}

parameters{
  real<lower=0, upper=1> p; //表の出る確率
}

model{
  D ~ binomial(N, p); //二項分布
}
