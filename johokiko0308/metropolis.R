p <- function(x){
  return(-x*(x-0.5)^2*(x-1))
}
x<-0:100/100
plot(x,p(x),'l')

step <- function(x){
  x_next <- x + runif(1, min=-1, max=1)#この幅は調整する
  r <- p(x_next)/p(x)
  if(r > 1){
    return(x_next)
  }
  else{
    q <- runif(1)
    if(r>q) return(x_next)
    else return(x)
  }
}
sample <- c()
sample[1] <- runif(1)
N <- 10000
for(i in 1:(N-1)){
  sample[i+1] <- step(sample[i])
}
hist(sample)
