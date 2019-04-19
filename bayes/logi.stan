data{
  int N;
  int y[N];
  real x[N];
}

parameters{
  real a;
  real b;
}

transformed parameters{
  real<lower=0,upper=1> p[N];
  for(i in 1:N){
    p[i] = inv_logit(a+b*x[i]);
  }
}

model{
  a ~ normal(0,100);
  b ~ normal(0,100);
  y ~ bernoulli(p);
}
