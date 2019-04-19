data{
  int N;
  real x[N];
}

parameters{
  real mu;
  real<lower=0> sigma;
}

model{
  for(i in 1:N){
      target += normal_lpdf(x[i] | mu, sigma);
  }
}
