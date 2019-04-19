data{
  int D;  //表のでた回数
  int N;  //投げた回数
}
parameters{
  real<lower=0,upper=1> p;  //表のでる確率
}
model{
  D ~ binomial(N,p);  //表の回数は二項分布に従う
}
