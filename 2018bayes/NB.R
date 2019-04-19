install.packages("RMeCab", repos = "http://rmecab.jp/R")

#https://qiita.com/hujuu/items/314a64a50875cdabf755
library(RMeCab)
library(ggplot2)
library(tidyverse)

# 解析対象となるデータの読み込み
res <- RMeCabFreq("steve-jobs-speech.txt")

res %>%
  dplyr::distinct(Term, .keep_all = TRUE) %>%
  dplyr::select(Term, Freq) %>%
  spread(key = Term, value = Freq)
