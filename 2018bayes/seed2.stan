data {
  int<lower=0> N; // サンプルサイズ
  int<lower=0> y[N]; // 種子 8 個当たりの生存数(目的変数)
}

parameters {
  real beta; // 全個体共通のロジスティック偏回帰係数
  vector[N] r; // 個体差
  real<lower=0> s; // 個体差のばらつき
}

transformed parameters {
  vector[N] q;
  q = inv_logit(beta + r);
    // 生存確率を個体差でロジット変換
}

model {
  y ~ binomial(8,q);
  beta~normal(0,100); // ロジスティック偏回帰係数の無情報事前分布
  r ~ normal(0,s);
  s ~ uniform(0,10000); // r[i]を表現するための無情報事前分布
}
