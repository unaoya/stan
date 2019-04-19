# http://kefism.hatenablog.com/entry/2017/03/14/231005
# リープフロッグ法
T <- 1000 # ステップの数
epsilon <- 0.01 # 1ステップで状態変化をどの程度許すか
p0 <- 1 # pの初期値
x0 <- 1 # xの初期値
p <- c(p0) # ステップtにおけるpの値p[t]
x <- c(x0) # ステップtにおけるxの値x[t]
DU <- function(x){x} # ポテンシャル U = -log(p(x))のx微分
# p(x)を標準正規分布(1/sqrt(2*pi))exp(-x^2/2)とする
DV <- function(p){p} # 運動エネルギー V = p^2/2のp微分
# この辺自動微分したい

for(t in 1:T){
  x.temp <- x[t] - (epsilon/2)*DV(p[t])
  p[t+1] <- p[t] + (epsilon/2)*DU(x[t])
  x[t+1] <- x.temp - (epsilon/2)*DV(p[t+1])
}
plot(x,p)

# H(x,p) = V(p) + U(x)の値
# f(y) = exp(-y)として密度函数q(x,p)=f(H(x,p))に従うサンプリング

plot(x)
