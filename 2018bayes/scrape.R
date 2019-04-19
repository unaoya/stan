#参考ページ
#https://qiita.com/rmecab/items/4408d6fb5ba03473f33a
#http://aidiary.hatenablog.com/entry/20100613/1276389337

library(stringr)
library(rvest)
library(RMeCab)
library(dplyr)
library(tidyr)

# 記事データを集める
url.list.b <- list(10)
for(i in 1:11){
  url <- str_c('https://news.yahoo.co.jp/hl?c=base&p=',as.character(i))
  url.list.b[[i]] <- read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[!is.na(.)] %>%
    .[str_detect(string = ., "headlines(.*hl)")] %>%
    .[1:(length(.)-5)]
}

url.list.s <- list(10)
for(i in 1:10){
  url <- str_c('https://news.yahoo.co.jp/hl?c=socc&p=',as.character(i))
  url.list.s[[i]] <- read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[!is.na(.)] %>%
    .[str_detect(string = ., "headlines(.*hl)")] %>%
    .[1:(length(.)-5)]
}

url.b <- unlist(url.list.b)
url.s <- unlist(url.list.s)

docs.b <- list(length(url.b))
for(j in 1:length(url.b)){
  docs.b[[j]] <- read_html(url.b[j]) %>%
    html_nodes(xpath = "//p[@class = 'ynDetailText']") %>%
    .[1] %>%
    html_text()
  Sys.sleep(1)
}

docs.s <- list(length(url.s))
for(j in 1:length(url.s)){
  docs.s[[j]] <- read_html(url.s[j]) %>%
    html_nodes(xpath = "//p[@class = 'ynDetailText']") %>%
    .[1] %>%
    html_text()
  Sys.sleep(1)
}

write(unlist(docs.b), "base.txt")
write(unlist(docs.s), "socc.txt")

#記事を形態素解析して、単語のリストを作る
#動詞と名詞のみ

words.b <- tibble(id=0)
for(i in 1:240){
  write(docs.b[[i]], "temp.txt")
  words.b <- RMeCabFreq("temp.txt") %>%
    dplyr::as_tibble() %>%
    dplyr::filter(Info1 == "動詞" | Info1 == "名詞") %>%
    dplyr::distinct(Term, .keep_all = TRUE) %>%
    dplyr::select(Term, Freq) %>%
    dplyr::mutate(id = i, class = 'b') %>%
    dplyr::full_join(words.b)
}
words.b <- words.b[-(dim(words.b)[1]),]

words.b.test <- tibble(id=0)
for(i in 241:250){
  write(docs.b[[i]], "temp.txt")
  words.b.test <- RMeCabFreq("temp.txt") %>%
    dplyr::as_tibble() %>%
    dplyr::filter(Info1 == "動詞" | Info1 == "名詞") %>%
    dplyr::distinct(Term, .keep_all = TRUE) %>%
    dplyr::select(Term, Freq) %>%
    dplyr::mutate(id = i, class = 'b') %>%
    dplyr::full_join(words.b)
}
words.b.test <- words.b.test[-(dim(words.b)[1]),]

words.s <- tibble(id=0)
for(i in 1:240){
  write(docs.s[[i]], "temp.txt")
  words.s <- RMeCabFreq("temp.txt") %>%
    dplyr::as_tibble() %>%
    dplyr::filter(Info1 == "動詞" | Info1 == "名詞") %>%
    dplyr::distinct(Term, .keep_all = TRUE) %>%
    dplyr::select(Term, Freq) %>%
    dplyr::mutate(id = (i + 250), class = 's') %>%
    dplyr::full_join(words.s)
}
words.s <- words.s[-(dim(words.s)[1]),]

words.s.test <- tibble(id=0)
for(i in 241:250){
  write(docs.s[[i]], "temp.txt")
  words.s.test <- RMeCabFreq("temp.txt") %>%
    dplyr::as_tibble() %>%
    dplyr::filter(Info1 == "動詞" | Info1 == "名詞") %>%
    dplyr::distinct(Term, .keep_all = TRUE) %>%
    dplyr::select(Term, Freq) %>%
    dplyr::mutate(id = (i + 250), class = 's') %>%
    dplyr::full_join(words.s)
}
words.s.test <- words.s.test[-(dim(words.s)[1]),]

words <- dplyr::full_join(words.b, words.s)
words.test <- dplyr::full_join(words.b.test, words.s.test)
write.csv(words, "train.csv")
write.csv(words.test, "test.csv")

#それぞれの確率を計算する

words <- read.csv("train.csv")
words <- words %>%
  tidyr::spread(key = Term, value = Freq, fill = 0)
num.words <- dim(words)[2] - 2 #idとclassのぶん減らす

words.count <- dplyr::group_by(words, class) %>%
  dplyr::select(-id) %>%
  dplyr::summarise_all(dplyr::funs(sum))

prob <- function(w,c){
  denom <- words.count %>%
    dplyr::filter(class == c) %>%
    dplyr::select(-class) %>%
    sum() + num.words

  numer <- try(words.count %>%
                 dplyr::filter(class == c) %>%
                 dplyr::select(w))
  if(class(numer)[1] == 'try-error') numer <- 0
  numer <- numer + 1

  return(log(numer) - log(denom))
}

prob('ボール', 'b')
#新規文書の分類

test <- read.csv('test.csv', stringsAsFactors=FALSE) %>%
  dplyr::filter(id == 250)
sum(prob(test$Term,'b')) + log(0.5)
sum(prob(test$Term,'s')) + log(0.5)

