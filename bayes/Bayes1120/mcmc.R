N <- 10000 #サンプル数
x <- rnorm(N) #標準正規分布に従う乱数
x
hist(x)
sum(x)/N #平均の計算

x <- c(1,2,3)
x

x <- c()
x

x <- runif(100)
y <- runif(100)
plot(x,y)
x[1]^2+y[1]^2
x[2]^2+y[2]^2
x[3]^2+y[3]^2
z <- c()
for(i in 1:100){
  z[i] <- x[i]^2+y[i]^2
}
z
ifelse(z[1]<1,1,0)
# z[1]<1なら1を返しz[1]>=1なら0を返す
r <- c()
for(i in 1:100){
  r[i] <- ifelse(z[i]<1,1,0)
}
r
sum(r)*4/100 #円周率の近似

N <- 100000
x <- runif(N)
y <- runif(N)
z <- c()
for(i in 1:N){
  z[i] <- x[i]^2+y[i]^2
}
r <- c()
for(i in 1:N){
  r[i] <- ifelse(z[i]<1,1,0)
}
sum(r)*4/N #円周率の近似
