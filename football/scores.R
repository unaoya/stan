library(stringr)
library(dplyr)
library(tidyr)
library(rstan)

#グループリーグのデータ
d <- read.csv("world-cup/2018--russia/cup.txt")
res <- d[str_detect(d[,1], pattern = "[0123456789]-[0123456789]"),1]
res_split <- str_split(res, pattern = " +")
team1 <- c()
team2 <- c()
score <- c()
for (i in 1:48){
  idx <- (1:(length(res_split[[i]])))[str_detect(res_split[[i]], pattern = "[0123456789]-[0123456789]")]
  team1[i] <- res_split[[i]][idx[1] - 1]
  score[i] <- res_split[[i]][idx[1]]
  team2[i] <- res_split[[i]][idx[length(idx)] + 1]
}
(df <- data.frame(team1, team2, score, gf=rep('gl', 48)))

df <- df %>%
  dplyr::mutate(score1 = as.numeric(str_sub(.$score, start=1, end=1))) %>%
  dplyr::mutate(score2 = as.numeric(str_sub(.$score, start=-1, end=-1)))
df <- data.frame(team = as.factor(c(as.character(df$team1), as.character(df$team2))),
                 score = c(df$score1, df$score2),
                 gf = rep('gl', 48))

df$team <- as.character(df$team)
df$team[df$team == "Rica"] <- "Costa Rica"
df$team[df$team == "Costa"] <- "Costa Rica"
df$team[df$team == "Saudi"] <- "Saudi Arabia"
df$team[df$team == "Arabia"] <- "Saudi Arabia"
df$team[df$team == "South"] <- "South Korea"
df$team[df$team == "Korea"] <- "South Korea"
df$team <- as.factor(df$team)

#決勝トーナメントのデータ
res <- read.csv("world-cup/2018--russia/cup_finals.txt", row.names = NULL) %>%
  dplyr::rename_(a=colnames(.)[1],b=colnames(.)[2]) %>%
  dplyr::mutate(res = str_c(.$a, .$b, sep = " ")) %>%
  dplyr::filter(str_detect(.$res, pattern = "[0123456789]-[0123456789]")) %>%
  dplyr::select(res)
res
team1 <- c()
team2 <- c()
score <- c()
for (i in 1:14){
  res_split <- str_split(res[i,], pattern = " +")
  idx <- (1:(length(res_split[[1]])))[str_detect(res_split[[1]], pattern = "[0123456789]-[0123456789]")]
  team1[i] <- res_split[[1]][idx[1] - 1]
  score[i] <- res_split[[1]][idx[1]]
  team2[i] <- res_split[[1]][idx[length(idx)] + 1]
}
class(score)
#PKになった試合
res %>%
  dplyr::filter(str_detect(.$res, pattern = "pen."))
score[3] <- '1-1'
score[4] <- '1-1'
score[8] <- '1-1'
score[11] <- '2-2'
(df2 <- data.frame(team1, team2, score, gf=rep('fi', 14)))
df2 <- df2 %>%
  dplyr::mutate(score1 = as.numeric(str_sub(.$score, start=1, end=1))) %>%
  dplyr::mutate(score2 = as.numeric(str_sub(.$score, start=-1, end=-1)))
df2
df <- rbind(df,data.frame(team = as.factor(c(as.character(df2$team1), as.character(df2$team2))),
                          score = c(df2$score1, df2$score2),
                          gf = rep('fi', 14)))
df <- data.frame(df, team_n = as.numeric(df$team), gf_n = as.numeric(df$gf) - 1)
df
?aggregate
aggregate(.~team, data = df, mean)
df[df$team=="France",]
df[df$team=="Croatia",]
# Stanで分析
d <- list(N = dim(df)[1],
          M = length(levels(df$team)),
          X = df$score,
          team = df$team_n,
          gf = df$gf_n)
fit <- stan(file = "poisson.stan", data=d, iter = 4000)
fit

r_fr <- rstan::extract(fit)$r[,11]
r_cr <- rstan::extract(fit)$r[,7]
beta1 <- rstan::extract(fit)$beta[,1]
beta2 <- rstan::extract(fit)$beta[,2]
hist(beta1)
lambda_fr <- exp(beta1 + r_fr + beta2)
lambda_cr <- exp(beta1 + r_cr + beta2)
hist(lambda_fr)
hist(lambda_cr)

mean(dpois(x = 0, lambda = lambda_cr))
mean(dpois(x = 1, lambda = lambda_cr))
mean(dpois(x = 2, lambda = lambda_cr))
mean(dpois(x = 3, lambda = lambda_cr))
mean(dpois(x = 4, lambda = lambda_cr))
mean(dpois(x = 5, lambda = lambda_cr))

mean(dpois(x = 0, lambda = lambda_fr))
mean(dpois(x = 1, lambda = lambda_fr))
mean(dpois(x = 2, lambda = lambda_fr))
mean(dpois(x = 3, lambda = lambda_fr))
mean(dpois(x = 4, lambda = lambda_fr))
mean(dpois(x = 5, lambda = lambda_fr))
