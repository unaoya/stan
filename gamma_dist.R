#指数分布とガンマ分布

#イベントがランダムに発生する、初めて発生するのにかかる時間
expdens <- function(x) lambda * exp(-lambda * x)
#パラメータ lambda, 平均1/lambda, 分散1/lambda^2

#幾何分布
#ベルヌーイ試行、初めて成功するのに何回かかるか
geom <- function(n) (1-p)^(n-1) * p
#パラメータp, 平均1/p, 分散(1-p)/p^2

p <- 0.5
plot(geom,0,10)
lambda <- 0.5
plot(expdens,0,10)

#ガンマ関数
# \Gamma(x)=\int^\infty_0t^{x-1}e^{-t}dt
# 階乗の一般化

#ガンマ分布
#パラメータk, lambda=1/theta
#k=1が指数分布
#平均k/lambda, 分散k/lambda^2
#イベントがk回起こるまでの時間

#負の二項分布
# 確率pの試行、k回成功するのに必要な回数の確率

# ポアソン分布の正規近似について
N <- 100000
lambda <- 30
x <- rpois(n = N, lambda = lambda)
hist(x, breaks=0:max(x))
y <- rnorm(n = N, mean = lambda, sd = sqrt(lambda))
hist(y, breaks=0:max(y))
