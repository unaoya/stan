pi<-function(x, log=FALSE) {
  dnorm(x, 10, 1, log=log)
}
p <- function(x,y,log=FALSE){
  dnorm(y, x, log=log)
}
alpha <- function(x, y) {
  return(exp(pi(y,log=TRUE) + p(y,x,log=TRUE) -
               pi(x, log=TRUE) - p(x, y, log=TRUE)))
}

MCMC <- function(X0, N) {
  X<-numeric(length=N)
  Xj <- X0
  for(j in 1:N){
    Yj <-rnorm(1, Xj)
    U <- runif(1)
    if( U < alpha(Xj,Yj) ){
      Xj <- Yj }
    X[j] <- Xj }
  return( c(X0, X) )
}

N <- 1000
j <- 0:N
X <- MCMC(0, N)
plot(j,X, type="l", ylab=expression(X[j]) )
hist(X[-c(1:200)], freq=FALSE)
curve(dnorm(x,10,1),add=TRUE,lty=2)
qqnorm(X[-c(1:200)])

qqline(X[-c(1:200)],col="red",lwd=2)
