data{
  int N; //
  real y[N]; // 1 
  real x[N]; // 2
}

parameters{
  real mu_y; //y     
  real<lower=0> sigma_y; //y      
  real mu_x; //x     
  real<lower=0> sigma_x; //x     
}

model{
  mu_y ~ normal(0,100); //      
  sigma_y ~ cauchy(0,5);//        
  mu_x ~ normal(0,100); //       
  sigma_x ~ cauchy(0,5);//       
  y ~ normal(mu_y,sigma_y);
  x ~ normal(mu_x,sigma_x);
}

generated quantities{ 
  real diff; //2       
  diff = mu_x-mu_y;
}
