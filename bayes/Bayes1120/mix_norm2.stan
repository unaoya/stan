data{
  int N;
  int M;
  real x[N];
}
parameters{
  real mu[M];
  real<lower=0> sigma[M];
  simplex[M] pi;
}
model{
  for(n in 1:N){
    for(m in 1:M){
      target += log(pi[m]) + normal_lpdf(x[n] | mu[m], sigma[m]);
    }
  }
}
