data{
  int N;
  real Y[N];
}

parameters{
  real mu[N];
  real<lower=0> s_Y;
}

model {
	  for (n in 1:N) {
    Y[n] ~ normal(mu[n], s_Y);
  }
}

generated quantities{
	vector[N] log_lik;
	for(n in 1:N){
			log_lik[n] = normal_lpdf(Y[n] | mu[n], s_Y);
	}
}
