data {
  int N;
  int M;
  real x[N];
}

parameters {
  real mu[M];
  real<lower=0> sigma[M];
  simplex[M] pi;
}

model {
  real ps[M];
  for(n in 1:N){
    ps[1] = log(pi[1]) + normal_lpdf(x[n], mu[1], sigma[1]);
    ps[2] = log(pi[2]) + normal_lpdf(x[n], mu[2], sigma[2]);
    target += log_sum_exp(ps);
  }
}
