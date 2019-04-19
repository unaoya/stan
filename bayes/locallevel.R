#ローカルレベルモデル
z<-rnorm(100)
y<-0
for (i in 1:100){
  y[i+1]<-y[i]+z[i]
}
plot(y,type='l')
noise<-rnorm(101)
y<-y+noise
plot(y,type='l')

#この y をデータとしてパラメータ推定する。

#の前にナイル川データでやってみる
Nile
plot(Nile)
y<-list(y=as.numeric(Nile),T=length(Nile))
y

library(rstan)
fit <- stan(file = 'locallevel.stan', data = y,
                 iter = 1000, chains = 4)

fit
#状態の事後分布
stan_dens(fit)
x<-rstan::extract(fit)$x
#状態の推定結果を可視化する
head(x)
d2<-data.frame(x)
up<-c()
lo<-c()
M<-c()
#forじゃなくてaggregateでやる
for(i in 1:length(d2)){
  up[i]<-quantile(d2[,i],0.975)
  lo[i]<-quantile(d2[,i],0.025)
  M[i]<-mean(d2[,i])
}

df<-data.frame(y=y$y, t=1:y$T, x=M, upper=up, lower=lo)
g<-ggplot(data = df, aes(x = t, y = y))
g<-g+geom_point()
g<-g+geom_errorbar(data = df, aes(ymin=lower, ymax=upper, x=t))
g<-g+geom_line(aes(x=t,y=x),data=df)
g
