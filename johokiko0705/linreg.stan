data{
  int N;  //サンプル数
  real AirFlow[N];  //説明変数
  real WaterTemp[N];  //説明変数
  real AcidConc[N];  //説明変数
  real stackloss[N];  //目的変数
}

parameters{
  real a[4]; //回帰係数
  real<lower=0> sigma;  //誤差の標準偏差
}

model{
  for(i in 1:N){
    stackloss[i] ~ normal(a[1]*AirFlow[i] + a[2]*WaterTemp[i] + a[3]*AcidConc[i] + a[4], sigma);
  }
}
