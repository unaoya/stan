data <- read.csv("Chap1.1.csv", fileEncoding="cp932")
data
str(data)

#乙と甲ごとのデータにして，差の平均値比較
otu.dis <- (data$height2 - data$height1)[data$給食 == "乙"]
kou.dis <- (data$height2 - data$height1)[data$給食 == "甲"]
mean(otu.dis)
mean(kou.dis) 
#乙タイプのが悪い???
#平均身長や 1 年での伸びに県ごとの差が存在するのでは?
#1 年後の計測はどれも人数が減少している?この影響は?

#一般化線形モデル
#\mu_{i,j} = \beta_1 + (\beta_2 + \beta3X_j)A_i
#データ加工
pref <- rep(c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"), 2) 
N <- c(data$n1, data$n2)
mean.Y <- c(data$height1, data$height2)
sd.Y <- c(data$sd1, data$sd2)
Age <- rep(c(0,1),each = 10)
X <- as.numeric(data$給食)
X <- c(abs(X-2), abs(X-2))
d <- data.frame(pref, N, mean.Y, sd.Y, Age, X)
d
#モデル
GLM <- glm(mean.Y ~ 1 + Age + Age:X, data = d)
GLM
summary(GLM)

#GLM2 <- glm(mean.Y ~ Age*X, data = d)

#問題点
#対応あるデータを対応なしとして扱っている
#標準誤差の過少推定モデル

#ベイズモデルへ 事前分布の設定
#\beta は全て-10000 から 10000 の一様分布に (無情報事前分布)
#\sigma は 0 から 10000 の一様分布
data
library(rstan)
d <- list(N=10,
          height1=data$height1,
          height2=data$height2,
          X=X[1:10],
          N_beta=3,
          sd1=data$sd1,
          sd2=data$sd2)
fit <- stan(file='lunch.stan',data=d,
            iter=1000,chains=4)
fit
plot(fit)
stan_trace(fit,pars="beta")
stan_hist(fit,pars="beta")
stan_dens(fit,pars="beta",separate_chains = TRUE)

beta <- rstan::extract(fit)$beta
beta
sum(beta[,3]>0)/length(beta[,3])
