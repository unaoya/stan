library(rstan)
N<-6
x<-c(1,1.7,1.3,1.5,0.8,2.1)
y<-c(3.5,3.8,4.2,5.0,2.3,4.9)
plot(x,y)

N<-30
x<-runif(N)
noise<-rnorm(N,mean=0,sd=0.1)
a<-1
b<-2
y<-b+a*x+noise
d<-list(x=x, y=y, N=N)
fit<-stan(file='linreg.stan',data=d)
fit
stan_trace(fit)
stan_hist(fit)
stan_ac(fit)

a_sample <- rstan::extract(fit)$a
b_sample <- rstan::extract(fit)$b

plot(x,y)
for(i in 1:100){
  abline(b=a_sample[i],a=b_sample[i])
}
