data{
  int N;
  int x[N];
}
parameters{
  real<lower=0> lambda;
}
model{
  for(i in 1:N){
    x[i] ~ poisson(lambda);
  }
}
