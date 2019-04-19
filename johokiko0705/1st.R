1+2

rbinom(n=5, size=10, prob=0.7)
x1 <- rbinom(n = 100,
             size=10,
             prob = 0.8)
x1
hist(x1, breaks=0:10)

x2 <- rbinom(n = 100,
             size=10,
             prob = 0.7)
x3 <- rbinom(n = 100,
             size=10,
             prob = 0.6)
x4 <- rbinom(n = 100,
             size=10,
             prob = 0.5)
par(mfrow=c(2,2))
hist(x1, breaks=0:10)
hist(x2, breaks=0:10)
hist(x3, breaks=0:10)
hist(x4, breaks=0:10)

mu <- 0
sigma <- 1
f <- function(x){
  (1/sqrt(2*pi)*sigma)*exp(-(x-mu)^2/(2*sigma^2))
}
par(mfrow=c(1,1))
plot(f,-4,4)

N <- 1000000
x <- rnorm(N)
par(mfrow=c(2,2))
hist(x,breaks=(0:20)/2-5)
hist(x,breaks=(0:40)/4-5)
hist(x,breaks=(0:80)/8-5)
hist(x,breaks=(0:160)/16-5)

f <- function(p){30*p^4*(1-p)}
plot(f,0,1)

n <- 10000
alpha <- 3
beta <- 4
x<-rbeta(n = n, shape1 = alpha, shape2 = beta)
f <- function(x){x^(alpha-1)*(1-x)^(beta-1)*n*0.05/beta(alpha, beta)}
hist(x)
plot(f,0,1, add=TRUE)

alpha <- 2
beta <- 5
x<-rbeta(n = n, shape1 = alpha, shape2 = beta)
f <- function(x){x^(alpha-1)*(1-x)^(beta-1)*n*0.05/beta(alpha, beta)}
hist(x)
plot(f,0,1, add=TRUE)

alpha <- 1
beta <- 6
x<-rbeta(n = n, shape1 = alpha, shape2 = beta)
f <- function(x){x^(alpha-1)*(1-x)^(beta-1)*n*0.05/beta(alpha, beta)}
hist(x)
plot(f,0,1, add=TRUE)

alpha <- 4
beta <- 3
x<-rbeta(n = n, shape1 = alpha, shape2 = beta)
f <- function(x){x^(alpha-1)*(1-x)^(beta-1)*n*0.05/beta(alpha, beta)}
hist(x)
plot(f,0,1, add=TRUE)
