N<-100 #個体数
s<-3 #個体差の標準偏差
r<-rnorm(n = N, mean = 0, sd = s) #個体差パラメータ
beta<-1 #共通パラメータ
q<-1/(1+exp(-r-beta)) #各個体の種子の生存確率
y<-NULL
for(i in 1:N){
  y[i] <- rbinom(n = 1, size = 8, prob = q[i])
}
hist(y)
mean(y)
var(y)
# 二項分布より分散が大きい。

# 個体差を入れた階層モデルを考える。
d<-list(y=y,N=N)
fit<-stan(file = "green10.stan", data = d)
plot(fit)
