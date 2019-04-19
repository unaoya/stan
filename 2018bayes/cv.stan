data {
  int N_train;
  int N_test;
  vector[N_train] X_train;
}

parameters {
  vector[N_train] alpha;
  real<lower=0> s_X;
  real<lower=0> s_a;
}

model {
  X_train ~ normal(alpha, s_X);
  alpha[2:N_train] ~ normal(alpha[1:(N_train-1)], s_a);
}

generated quantities {
  vector[N_train+N_test] alpha_all;
  vector[N_test] X_pred;
  alpha_all[1:N_train] = alpha;
  for (t in 1:N_test) {
    alpha_all[N_train+t] = normal_rng(alpha_all[N_train+t-1], s_a);
    X_pred[t] = normal_rng(alpha_all[N_train+t], s_X);
  }
}
