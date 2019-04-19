Niter <- 10000
x <- 0
y <- 0
rho <- 0.6

for (i in 2:Niter){
  x[i] <- rnorm(1, rho*y[i-1], sqrt(1-rho^2))
  y[i] <- rnorm(1, rho*x[i], sqrt(1-rho^2))
}

plot(x, y, xlim=c(-5,5), ylim=c(-5,5))

install.packages('animation')
library(animation)

gibbs <- function(){
  Niter <- 1000
  x1 <- 0
  y1 <- 0
  rho <- 0.7
  
  for (i in 2:Niter){
    x1[i] <- rnorm(1, rho*x2[i-1], sqrt(1-rho^2))
    plot(c(x1[1], rep(x1[2:i],each=2)[-(i-1)*2]), rep(x2[1:i-1], each=2),
         col='gray', type='b',
         xlim=c(-5,5), ylim=c(-5,5), xlab="x1", ylab="x2")
    lines(c(x1[i-1],x1[i]), c(x2[i-1],x2[i-1]), type='b', pch=19)
    x2[i] <- rnorm(1, rho*x1[i], sqrt(1-rho^2))
    plot(c(x1[1], rep(x1[2:i],each=2)), rep(x2[1:i], each=2)[-i*2],
         col='gray', type='b',
         xlim=c(-5,5), ylim=c(-5,5), xlab="x1", ylab="x2")
    lines(c(x1[i],x1[i]), c(x2[i-1],x2[i]), type='b', pch=19)
  }
}

saveGIF(gibbs(), interval=0.1, moviename="",
        movietype="gif", outdir=getwd(),
        width=640, height=480)

install.packages('MCMCpack')
library(MCMCpack)

x <- seq(0.001, 4, length=1000)
d <- dinvgamma(x, 0.01, 0.01)
plot(d~x, type='l', las=1, xlab="variance", ylab="density", col='red')

data <- c(6,10,7.6,3.5,1.4,2.5,5.6,3.0,2.2,5.0,
          3.3,7.6,5.8,6.7,2.8,4.8,6.3,5.3,5.4,3.3,
          3.4,3.8,3.3,5.7,6.3,8.4,4.6,2.8,7.9,8.9)
data
mu <- 5
sigma2 <- 4.00

for (i in 1:100000){
  mu[i] <- rnorm(1, (30*mean(data)/sigma2[i-1] + 5/(4*sigma2[i-1]))) / (30/sigma2[i-1] * 1/(4*sigma2[i-1])), 1/(30/sigma2[i-1] + 1/sigma2[i-1]))
  sigma2[i] <- rinvsigma(1, 15.01,
                         (138.2187 + 30*(mu[i]-5.106667)^2 + 0.02)/2)
}

mu
sigma2

plot(mu)
plot(sigma2)
plot(mu, sigma2)

mean(mu[1001:10000])
mean(sigma2[1001:10000])

