data{
  int N;  //サンプル数
  int x[N];  //観測値
}
parameters{
  real<lower=0> lambda;  //ポアソン分布のパラメータ
}
model{
  for (i in 1:N){
    x[i] ~ poisson(lambda);  //ポアソン分布モデル
    }
}
