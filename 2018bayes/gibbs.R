b = -0.8
x = 3.0
y = 9.0
imax = 100

plot(0,0,xlim=c(-10.0,10.0), ylim=c(-10.0,10.0),type='n')
title(c(paste("Gibbs sampler"), paste("b=",b)))

for(i in 1:imax){
  xold = x
  x = rnorm(1,mean=b*y,sd=1.0)
  lines(c(xold,x),c(y,y),type='b',col=3,lwad=2)
  scan(stdin())
  yold = y
  y = rnorm(1,mean=b*x,sd=1.0)
  lines(c(x,x),c(yold,y),type='b',col=3,lwad=2)
  scan(stdin())
}

]
