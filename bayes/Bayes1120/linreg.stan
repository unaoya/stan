data{
  int N;
  int M;
  #real x[N];
  matrix[N,M] x;
  vector[N] y;
}
parameters{
  #real a;
  #real b;
  vector[M] a;
  real<lower=0> sigma;
}
model{
  y ~ normal(x*a,sigma)
  #for(i in 1:N){
  #  y[i] ~ normal(b+a*x[i],sigma);
  #}
}
