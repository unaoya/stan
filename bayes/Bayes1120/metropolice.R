# メトロポリス法
p <- function(x){
  return(6*x*(1-x))
} #目標の確率密度関数（ベータ分布）
p(0.5)
x <- 0:100/100
x

step <- function(x){
  x_next <- x + runif(1, min=-1, max=1)
  r <- p(x_next)/p(x)
  if(r > 1){
    return(x_next)
  }  else{
    q <- runif(1)
    if(r > q) return(x_next)
    else return(x)
  }
}
sample <- c()
sample[1] <- runif(1)
N <- 10000
for(i in 1:(N-1)){
  sample[i+1] <- step(sample[i])
}
par(mfrow=c(1,2))
plot(x,p(x),'l')
hist(sample)
