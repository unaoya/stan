data{
  int D;
  int N;
}
parameters{
  real<lower=0,upper=1> p;
}
model{
  D ~ binomial(N,p);
}
