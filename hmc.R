T <- 0.01
x <- 0
p <- 0
for(i in 2:10000){
  p[i] <- rnorm(n=1, mean=0, sd=1)
  x[i] <- p[i]*T + x[i-1]
  p[i] <- p[i]
}
hist(p)
hist(x)

T <- 0.1
x <- 1
p <- 0
b <- 0
for(i in 2:10000){
  b[i-1] <- acos(x[i-1]/sqrt(x[i-1]^2+p[i-1]^2))
  x[i] <- sqrt(x[i-1]^2+p[i-1]^2)*cos(T+b[i-1])
  p[i] <- sqrt(x[i-1]^2+p[i-1]^2)*sin(T+b[i-1])
}
b[31:40]
x[31:40]
p[31:40]