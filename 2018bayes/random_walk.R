for(i in 1:100){
  z<-rnorm(100)
  y<-0
  for (i in 1:100){
    y[i+1]<-y[i]+z[i]
  }
  plot(y,type='l',ylim=c(-100,100))
  par(new=T)
}

plot(1,2)
plot.new()

#コーシー分布でランダムウォーク
for(i in 1:1){
  z<-rcauchy(100, location = 0, scale = 0.1)
  y<-0
  for (i in 1:100){
    y[i+1]<-y[i]+z[i]
  }
  plot(y,type='l',ylim=c(-100,100))
  par(new=T)
}

