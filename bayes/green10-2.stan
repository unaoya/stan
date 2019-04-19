data{
  int N;
  int Npot;
  int pot[N];
  int y[N];
  int f[N];
}

parameters{
  real r[N];
  real rpot[Npot];
  real beta1;
  real beta2;
  real<lower=0> s1;
  real<lower=0> s2;
}
transformed parameters{
  real lambda[N];
  for(i in 1:N){
    lambda[i] = inv_logit(beta1+beta2*f[i]+r[i]+rpot[pot[i]]);
  }
}
model{
  s1 ~ cauchy(0,5);
  s2 ~ cauchy(0,5);
  beta1 ~ normal(0,100);
  beta2 ~ normal(0,100);
  for(i in 1:N){
    r[i] ~ normal(0,s1);
  }
  for(i in 1:Npot){
    rpot[i] ~ normal(0,s2);
  }
}
