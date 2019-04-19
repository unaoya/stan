data {
  int T; //サンプルサイズ
  real y[T]; //観測値
}
parameters {
  real x[T]; //状態
  real<lower=0> sigma_s; //状態のノイズの分散
  real<lower=0> sigma_o; //観測のノイズの分散
}
model {
  for (i in 1:T){
    y[i] ~ normal(x[i], sigma_o);  //観測方程式
  }
  for (i in 2:T){
    x[i] ~ normal(x[i-1], sigma_s); //状態方程式
  }
}
