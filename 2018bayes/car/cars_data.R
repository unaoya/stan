#https://suryu.me/post/tabulizer_fantastic_extract_data_from_pdf/
install.packages('githubinstall')
library(githubinstall)
githubinstall('tabulizerjars')
githubinstall('tabulizer')
install.packages('rJava')
#うまくいかない, dependencies = T, type='source')
#java8にしてるのが関係ある？

library(dplyr)
library(purrr)
library(tabulizer)

path2pdf <- "car_data/ranking201412.pdf"
locate_areas(path2pdf, pages = 2, widget = "shiny")

out1 <- extract_tables(path2pdf, 
                       output = "data.frame")#違う
out2 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,284,629,512)))
df1 <- out1 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2014年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df2 <- out2 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2014年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df14 <- rbind(df1, df2) %>%
  tidyr::spread(key = 車種, value = 台数)

path2pdf <- "car_data/ranking201512.pdf"
out1 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,54,629,274)))#違う
out2 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,284,629,512)))
df1 <- out1 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2015年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df2 <- out2 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2015年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df15 <- rbind(df1, df2) %>%
  tidyr::spread(key = 車種, value = 台数)

path2pdf <- "car_data/ranking201612.pdf"
out1 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,54,629,274)))#違う
out2 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,284,629,512)))
df1 <- out1 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2016年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df2 <- out2 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2016年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df16 <- rbind(df1, df2) %>%
  tidyr::spread(key = 車種, value = 台数)

path2pdf <- "car_data/ranking201712.pdf"
out1 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,54,629,274)))#違う
out2 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,284,629,512)))
df1 <- out1 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2017年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df2 <- out2 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2017年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df17 <- rbind(df1, df2) %>%
  tidyr::spread(key = 車種, value = 台数)

path2pdf <- "car_data/ranking201806.pdf"
out1 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,54,629,274)))#違う
out2 <- extract_tables(path2pdf, 
                       output = "data.frame",
                       area = list(c(94,284,629,512)))
df1 <- out1 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2018年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df2 <- out2 %>%
  map(~ .[c(2,4)]) %>%
  map(~ .[2:51,]) %>%
  map(~ mutate(., 月=paste('2018年',colnames(.)[1]))) %>%
  map(~ rename(., 台数=X.1)) %>%
  map(~ cbind(., select(., 車種=1))) %>%
  map_dfr(~ select(., c(4,2,3)))
df18 <- rbind(df1, df2) %>%
  tidyr::spread(key = 車種, value = 台数)
df <- rbind(df14[c(4,9:16,1:3),c('月', 'ノート', 'アクア', 'プリウス', 'セレナ', 'フィット')],
            df15[c(4,9:16,1:3),c('月', 'ノート', 'アクア', 'プリウス', 'セレナ', 'フィット')],
            df16[c(4,9:16,1:3),c('月', 'ノート', 'アクア', 'プリウス', 'セレナ', 'フィット')],
            df17[c(4,9:16,1:3),c('月', 'ノート', 'アクア', 'プリウス', 'セレナ', 'フィット')],
            df18[-c(2,3),c('月', 'ノート', 'アクア', 'プリウス', 'セレナ', 'フィット')])
rownames(df) <- df$月
df_sell <- df[,-1]

df_note <- as.numeric(read.csv('car_data/multiTimeline.csv')[,1])
df_aquq <- as.numeric(read.csv('car_data/multiTimeline-2.csv')[,1])
df_prius <- as.numeric(read.csv('car_data/multiTimeline-3.csv')[,1])
df_selena <- as.numeric(read.csv('car_data/multiTimeline-4.csv')[,1])
df_fit <- as.numeric(read.csv('car_data/multiTimeline-5.csv')[,1])
df_search <- data.frame(ノート=df_note,
                           アクア=df_aquq,
                           プリウス=df_prius,
                           セレナ=df_selena,
                           フィット=df_fit,
                           month=stringr::str_sub(rownames(read.csv('car_data/multiTimeline.csv')), end=-4))[-1,]
df_search <- df_search %>%
  dplyr::group_by(month) %>%
  dplyr::summarise(ノート=mean(ノート),
                      アクア=mean(アクア),
                      プリウス=mean(プリウス),
                      セレナ=mean(セレナ),
                      フィット=mean(フィット)) %>%
  dplyr::ungroup()
df_sell$ノート <- as.numeric(gsub(",", "", df_sell$ノート))#,があると数値にできない
df_sell$アクア <- as.numeric(gsub(",", "", df_sell$アクア))#,があると数値にできない
df_sell$プリウス <- as.numeric(gsub(",", "", df_sell$プリウス))#,があると数値にできない
df_sell$セレナ <- as.numeric(gsub(",", "", df_sell$セレナ))#,があると数値にできない
df_sell$フィット <- as.numeric(gsub(",", "", df_sell$フィット))#,があると数値にできない

plot(df_search$ノート[-(1:6)], type = 'l')
plot(df_sell$ノート, type = 'l')

write.csv(df_sell, 'car_sell.csv')
write.csv(df_search, 'car_search.csv')

df_search
