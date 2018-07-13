data{
  int N; //試合数の二倍
  int M; //チーム数
  int X[N]; //各試合、各チームの得点
  int team[N]; //チーム番号
  int gf[N]; //GLかトーナメントか
}

parameters{
  real r[M]; //チーム差
  real beta[2]; //係数
  real<lower=0> sigma; //チーム差の分散
}

transformed parameters{
    real lambda[N];
    for (i in 1:N){
      lambda[i] = exp(beta[1] + r[team[i]] + beta[2] * (gf[i] - 1));
    }
}

model {
    X ~ poisson(lambda);
    r ~ normal(0, sigma);
    sigma ~ cauchy(0, 5);
    beta ~ normal(0, 0.001);
}
