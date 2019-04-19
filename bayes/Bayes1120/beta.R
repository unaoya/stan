n <- 10000 #サンプル数
alpha1 <- 3 #ベータ分布のパラメータ
beta1 <- 4  #ベータ分布のパラメータ
x1 <- rbeta(n = n, shape1 = alpha1, shape2 = beta1) #ベータ分布のサンプリング

alpha2 <- 3 #ベータ分布のパラメータ
beta2 <- 5  #ベータ分布のパラメータ
x2 <- rbeta(n = n, shape1 = alpha2, shape2 = beta2) #ベータ分布のサンプリング

alpha3 <- 3 #ベータ分布のパラメータ
beta3 <- 7  #ベータ分布のパラメータ
x3 <- rbeta(n = n, shape1 = alpha3, shape2 = beta3) #ベータ分布のサンプリング

alpha4 <- 3 #ベータ分布のパラメータ
beta4 <- 10  #ベータ分布のパラメータ
x4 <- rbeta(n = n, shape1 = alpha4, shape2 = beta4) #ベータ分布のサンプリング

par(mfrow=c(2,2))
hist(x1)
hist(x2)
hist(x3)
hist(x4)

alpha <- 1 #事前分布のパラメータ
beta <- 1  #事前分布のパラメータ
par(mfrow=c(1,2))
p <- rbeta(n = n, shape1 = alpha, shape2 = beta) #事前分布のサンプリング
hist(p)
#データとして赤が3個白が2個得られたとする。
alpha_post <- 1+5 #事後分布
beta_post <- 1+1
p_post <- rbeta(n = n, shape1 = alpha_post, shape2 = beta_post) #事後分布のサンプリング
hist(p_post)
p_post #事後分布からのパラメータのサンプリング
#事後分布を用いて、次に赤いボールがでる確率を予測
sum(p_post)/n


N <- 10000
lambda <- 3
x <- rpois(n = N, lambda = lambda)
hist(x)

N <- 10000
lambda <- 5
x2 <- rpois(n = N, lambda = lambda)
hist(x2)

x<-c(8,4,5,5,7,9,7,5,5,4) # 得られたデータ

