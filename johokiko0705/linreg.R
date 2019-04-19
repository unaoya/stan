stackloss
?stackloss

library(rstan)
d<-list(AirFlow=stackloss$Air.Flow,
        WaterTemp=stackloss$Water.Temp,
        AcidConc=stackloss$Acid.Conc.,
        stackloss=stackloss$stack.loss,
        N=dim(stackloss)[1])
fit<-stan(file='linreg.stan',data=d)
fit

stan_trace(fit)
stan_ac(fit, separate_chains = T)
stan_dens(fit, separate_chains = T)

stan_hist(fit)

a_sample <- rstan::extract(fit)$a
b_sample <- rstan::extract(fit)$b

plot(x,y)
for(i in 1:100){
  abline(b=a_sample[i],a=b_sample[i])
}
