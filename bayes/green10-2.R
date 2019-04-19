N <- 100
Npot <- 10
pot <- c()
for(i in 1:Npot){
  pot<-c(pot,rep(i,10))
}
f <- c(rep(0,50),rep(1,50))
r <- rnorm(N)
r.j <- rnorm(Npot)
rpot <- c()
for(i in 1:Npot){
  rpot <- c(rpot,rep(r.j[i],10))
}
df <- data.frame(pot=pot,f=f,r=r,rpot=rpot)
df
beta1 <- 3.0
beta2 <- 2.0
lambda <- beta1 + beta2*df$f + df$r + df$rpot
df <- data.frame(df, lambda=lambda)
df
y <- c()
for(i in 1:N){
  y[i] <- rpois(1,df$lambda[i])
}
df <- data.frame(df, y=y)
plot(df$y)
mean(df$y)
var(df$y)

library(rstan)
d <- list(N=N, Npot=Npot, pot=df$pot, y=df$y, f=df$f)
fit <- stan(file = "green10-2.stan", data = d)
