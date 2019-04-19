library(rstan)
library(ggmcmc)
library(dplyr)
library(bayesplot)

# データの読み込み

df_sail <- read.csv('data/car_sail.csv')
df_search <- read.csv('data/car_search.csv')

# 販売量データは2014/1から2018/6まで（長さ54）
# 検索データは2013/7から2018/7まで（長さ61）
(sail <- df_sail$ノート)
(search <- df_search$ノート)

# 学習に2017/6まで、テストに2017/7から2018/6まで
N_test <- 12
data <- list(Y = sail[1:(length(sail)-N_test)],
             X = search[7:(length(sail)-N_test+6)],
             N = length(sail) - N_test,
             N_pred = N_test)

# ベースラインモデル
fit_base <- stan(file = "./model/base.stan",
                 data = data,
                 iter = 10000)

# 推定結果
mcmc_rhat(rhat(fit_base))

# 結果の図示
ggs(fit_base) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(`2.5%` = quantile(value, probs=.025),
            `10%`  = quantile(value, probs=.1),
            `50%`  = quantile(value, probs=.5),
            `90%`  = quantile(value, probs=.9),
            `97.5%`= quantile(value, probs=.975)) %>%
  mutate(sail = sail) %>%
  ggplot() +
  geom_ribbon(mapping=aes(x=x, ymin=`2.5%`, ymax=`97.5%`), alpha=1/6) +
  geom_ribbon(mapping=aes(x=x, ymin=`10%`,  ymax=`90%`),   alpha=2/6) +
  geom_line(mapping=aes(x=x, y=`50%`)) +
  geom_line(aes(x=x, y=sail), shape=1, size=2) +
  labs(x='月', y='販売台数') +
  ggtitle ("ベースラインモデル") +
  theme_gray (base_family = "HiraKakuPro-W3")

# 予測誤差
# 予測値の平均と実測値の二乗誤差
ggs(fit_base) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(mean = mean(value)) %>%
  mutate(sail = sail) %>%
  mutate(sqe=(sail-mean)^2) %>%
  select(sqe) %>%
  slice((length(sail)-11):length(sail)) %>%
  summarize(sum(sqe))

# 提案モデル
fit_uni0 <- stan(file = "./model/uni0.stan",
                     data = data,
                     iter = 10000)
# 推定結果
mcmc_rhat(rhat(fit_uni0))

# 結果の図示
ggs(fit_uni0) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(`2.5%` = quantile(value, probs=.025),
            `10%`  = quantile(value, probs=.1),
            `50%`  = quantile(value, probs=.5),
            `90%`  = quantile(value, probs=.9),
            `97.5%`= quantile(value, probs=.975)) %>%
  mutate(sail = sail) %>%
  ggplot() +
  geom_ribbon(mapping=aes(x=x, ymin=`2.5%`, ymax=`97.5%`), alpha=1/6) +
  geom_ribbon(mapping=aes(x=x, ymin=`10%`,  ymax=`90%`),   alpha=2/6) +
  geom_line(mapping=aes(x=x, y=`50%`)) +
  geom_line(aes(x=x, y=sail), shape=1, size=2) +
  labs(x='月', y='販売台数') +
  ggtitle ("同期モデル") +
  theme_gray (base_family = "HiraKakuPro-W3")

# 予測誤差
# 予測値の平均と実測値の二乗誤差
ggs(fit_uni0) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(mean = mean(value)) %>%
  mutate(sail = sail) %>%
  mutate(sqe=(sail-mean)^2) %>%
  select(sqe) %>%
  slice((length(sail)-11):length(sail)) %>%
  summarize(sum(sqe))

# 一期前のみ
fit_uni1 <- stan(file = "./model/uni1.stan",
                 data = data,
                 iter = 10000)

# 推定結果
mcmc_rhat(rhat(fit_uni1))

# 結果の図示
ggs(fit_uni1) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(`2.5%` = quantile(value, probs=.025),
            `10%`  = quantile(value, probs=.1),
            `50%`  = quantile(value, probs=.5),
            `90%`  = quantile(value, probs=.9),
            `97.5%`= quantile(value, probs=.975)) %>%
  mutate(sail = sail) %>%
  ggplot() +
  geom_ribbon(mapping=aes(x=x, ymin=`2.5%`, ymax=`97.5%`), alpha=1/6) +
  geom_ribbon(mapping=aes(x=x, ymin=`10%`,  ymax=`90%`),   alpha=2/6) +
  geom_line(mapping=aes(x=x, y=`50%`)) +
  geom_line(aes(x=x, y=sail), shape=1, size=2) +
  labs(x='月', y='販売台数') +
  ggtitle ("一期前モデル") +
  theme_gray (base_family = "HiraKakuPro-W3")

# 予測誤差
# 予測値の平均と実測値の二乗誤差
ggs(fit_uni1) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(mean = mean(value)) %>%
  mutate(sail = sail) %>%
  mutate(sqe=(sail-mean)^2) %>%
  select(sqe) %>%
  slice((length(sail)-11):length(sail)) %>%
  summarize(sum(sqe))

# 二期前のみ
fit_uni2 <- stan(file = "./model/uni2.stan",
                 data = data,
                 iter = 10000)

# 推定結果
mcmc_rhat(rhat(fit_uni2))

# 結果の図示
ggs(fit_uni2) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(`2.5%` = quantile(value, probs=.025),
            `10%`  = quantile(value, probs=.1),
            `50%`  = quantile(value, probs=.5),
            `90%`  = quantile(value, probs=.9),
            `97.5%`= quantile(value, probs=.975)) %>%
  mutate(sail = sail) %>%
  ggplot() +
  geom_ribbon(mapping=aes(x=x, ymin=`2.5%`, ymax=`97.5%`), alpha=1/6) +
  geom_ribbon(mapping=aes(x=x, ymin=`10%`,  ymax=`90%`),   alpha=2/6) +
  geom_line(mapping=aes(x=x, y=`50%`)) +
  geom_line(aes(x=x, y=sail), shape=1, size=2) +
  labs(x='月', y='販売台数') +
  ggtitle ("二期前モデル") +
  theme_gray (base_family = "HiraKakuPro-W3")

# 予測誤差
# 予測値の平均と実測値の二乗誤差
ggs(fit_uni2) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(mean = mean(value)) %>%
  mutate(sail = sail) %>%
  mutate(sqe=(sail-mean)^2) %>%
  select(sqe) %>%
  slice((length(sail)-11):length(sail)) %>%
  summarize(sum(sqe))

# 二期前まで全て使う
fit_mult <- stan(file = "./model/mult.stan",
                 data = data,
                 iter = 10000)

# 推定結果
mcmc_rhat(rhat(fit_mult))

# 結果の図示
ggs(fit_mult) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(`2.5%` = quantile(value, probs=.025),
            `10%`  = quantile(value, probs=.1),
            `50%`  = quantile(value, probs=.5),
            `90%`  = quantile(value, probs=.9),
            `97.5%`= quantile(value, probs=.975)) %>%
  mutate(sail = sail) %>%
  ggplot() +
  geom_ribbon(mapping=aes(x=x, ymin=`2.5%`, ymax=`97.5%`), alpha=1/6) +
  geom_ribbon(mapping=aes(x=x, ymin=`10%`,  ymax=`90%`),   alpha=2/6) +
  geom_line(mapping=aes(x=x, y=`50%`)) +
  geom_line(aes(x=x, y=sail), shape=1, size=2) +
  labs(x='月', y='販売台数') + 
  ggtitle ("複数期モデル") +
  theme_gray (base_family = "HiraKakuPro-W3")

# 予測誤差
# 予測値の平均と実測値の二乗誤差
ggs(fit_mult) %>%
  filter(grepl('^Y_all\\[\\d+\\]$', Parameter)) %>%
  tidyr::separate(Parameter, into=c('Parameter', 'x'), sep='[\\[\\]]', convert=TRUE) %>%
  group_by(Parameter, x) %>%
  summarize(mean = mean(value)) %>%
  mutate(sail = sail) %>%
  mutate(sqe=(sail-mean)^2) %>%
  select(sqe) %>%
  slice((length(sail)-11):length(sail)) %>%
  summarize(sum(sqe))
