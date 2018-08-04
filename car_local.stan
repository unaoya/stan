data {
  int N;
  int N_pred;
  vector[N] Y;
}

parameters {
  vector[N] alpha;
  real<lower=0> s_Y;
  real<lower=0> s_a;
}

model {
  Y ~ normal(alpha, s_Y);
  alpha[2:N] ~ normal(alpha[1:(N-1)], s_a);
}

generated quantities {
  vector[N+N_pred] alpha_all;
  vector[N_pred] Y_pred;
  alpha_all[1:N] = alpha;
  for (t in 1:N_pred) {
    alpha_all[N+t] = normal_rng(alpha_all[N+t-1], s_a);
    Y_pred[t] = normal_rng(alpha_all[N+t], s_Y);
  }
}
