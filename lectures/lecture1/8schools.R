#https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started-(Japanese)
library(rstan)
schools_dat <- list(J=8,
                    y=c(28,8,-1,7,-1,1,18,12),
                    sigma=c(15,10,16,11,9,11,10,18))
fit <- stan(file='8schools.stan',data=schools_dat,
            iter=1000,chains=4)
print(fit)
plot(fit)
pairs(fit,pars=c("mu","tau","lp__"))

la<-extract(fit,permuted=TRUE)
mu<-la$mu
la
a<-extract(fit,permuted=FALSE)

a2<-as.array(fit)
m<-as.matrix(fit)
