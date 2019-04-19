data{
  int N;
  real y[N];
}
parameters{
  real mu;
  real<lower=0> sigma;
}
model{
  mu ~ normal(0,100);
  sigma ~ cauchy(0,5);
  for(i in 1:N){
    y[i] ~ normal(mu,sigma);
  }
}
