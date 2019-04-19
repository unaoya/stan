#緑本9章の問題をStanでやる

#まずサンプルをlambda=exp(1.5+0.1x)をパラメータにもつポアソン分布から生成
#xは3から7で一様にとる
#サンプル数は20
x<-runif(20,min=3,max=7)
y<-vector()
for (i in 1:20){
  lambda<-exp(1.5+0.1*x[i])
  y[i]<-rpois(1,lambda)
}
plot(x,y)
df<-data.frame(x,y)
#GLMで推定
GLM<-glm(y~x,family=poisson,data=df)
GLM

d<-list(N=20, x=x, y=y)
#RStanで推定
library(rstan)
fit <- stan(file='green9.stan',data=d,
            iter=1000,chains=4)
print(fit)
# Rhatで収束判定
# サンプル列も見ておく
stan_trace(fit, pars=c("beta1","beta2"))

# 結果の分析
plot(fit)
pairs(fit)