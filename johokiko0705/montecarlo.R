sample <- function(n){
  x <- c()
  for(i in 1:n){
    r <- runif(2)
    x[i] <- ifelse(r[1]^2+r[2]^2<1, 1, 0)
  }
  return(x)
}

N <- 10000
areas<-c()
for (i in 1:100){
  areas[i] <- 4*sum(sample(N))/N
}
hist(areas)
