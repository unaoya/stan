N <- 100
a <- 1
b <- 1
x <- runif(N)
p <- 1/(1+exp(-a-b*x))
y <- NULL
for(i in 1:N){
  y[i] <- rbinom(n = 1, size = 1, prob = p[i])
}
plot(x,y)
d<-list(N=N,x=x,y=y)
fit<-stan(file = "logi.stan", data = d)
