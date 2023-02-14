#---------------------------------------------------------------------

# Seleção do modelo

#---------------------------------------------------------------------

# Unindo métricas

library(tidyverse)

# Precision

precision <- data[,c("algorithm","n_neighbors","metric","sizes","digits","precision")] %>% 
  spread(key=digits, value = precision)

names(precision)[5:14] <- c("0_precision", "1_precision", 
                            "2_precision", "3_precision", 
                            "4_precision", "5_precision", 
                            "6_precision", "7_precision", 
                            "8_precision","9_precision")

precision$key <- 1:nrow(precision)

# Recall

recall <- data[,c("algorithm","n_neighbors","metric","sizes","digits","recall")] %>% 
  spread(key=digits, value = recall)

names(recall)[5:14] <- c("0_recall", "1_recall", 
                         "2_recall", "3_recall", 
                         "4_recall", "5_recall", 
                         "6_recall", "7_recall",
                         "8_recall","9_recall")

recall$key <- 1:nrow(recall)

# F1_score

f1_score <- data[,c("algorithm","n_neighbors","metric","sizes","digits","f1_score")] %>% 
  spread(key=digits, value = f1_score)

names(f1_score)[5:14] <- c("0_f1_score", "1_f1_score", 
                           "2_f1_score", "3_f1_score", 
                           "4_f1_score", "5_f1_score", 
                           "6_f1_score", "7_f1_score", 
                           "8_f1_score","9_f1_score")

f1_score$key <- 1:nrow(f1_score)

# support

support <- data[,c("algorithm","n_neighbors","metric","sizes","digits","support")] %>% 
  spread(key=digits, value = support)

names(support)[5:14] <- c("0_support", "1_support", 
                          "2_support", "3_support", 
                          "4_support", "5_support", 
                          "6_support", "7_support",
                          "8_support","9_support")

support$key <- 1:nrow(support)

# Unindo dados

a <- left_join(precision, recall)
b <- left_join(a, f1_score)
c <- left_join(b, support)

names(c)

#---------------------------------------------------------------------

# Quantis

quantis <- data.frame(digit = 0:9,
                      `0%` = 1,
                      `25%` = 1,
                      `50%` = 1,
                      `75%` = 1,
                      `100%` = 1 )

quantis[1,2:6] <- as.vector(quantile(f1_score$`0`))
quantis[2,2:6] <- as.vector(quantile(f1_score$`1`))
quantis[3,2:6] <- as.vector(quantile(f1_score$`2`))
quantis[4,2:6] <- as.vector(quantile(f1_score$`3`))
quantis[5,2:6] <- as.vector(quantile(f1_score$`4`))
quantis[6,2:6] <- as.vector(quantile(f1_score$`5`))
quantis[7,2:6] <- as.vector(quantile(f1_score$`6`))
quantis[8,2:6] <- as.vector(quantile(f1_score$`7`))
quantis[9,2:6] <- as.vector(quantile(f1_score$`8`))
quantis[10,2:6] <- as.vector(quantile(f1_score$`9`))

t(quantis[,c(1,5)])

#---------------------------------------------------------------------

# Seleção dos modelo que tem f1_score maior que o quantil 75 para todos
# os dígitos

selecao <- subset(f1_score, 
                  f1_score$`0` >= quantile(f1_score$`0`)[4] &
                    f1_score$`1` >= quantile(f1_score$`1`)[4] &
                    f1_score$`2` >= quantile(f1_score$`2`)[4] &
                    f1_score$`3` >= quantile(f1_score$`3`)[4] &
                    f1_score$`4` >= quantile(f1_score$`4`)[4] &
                    f1_score$`5` >= quantile(f1_score$`5`)[4] &
                    f1_score$`6` >= quantile(f1_score$`6`)[4] &
                    f1_score$`7` >= quantile(f1_score$`7`)[4] &
                    f1_score$`8` >= quantile(f1_score$`8`)[4] &
                    f1_score$`9` >= quantile(f1_score$`9`)[4])

nrow(selecao)

names(selecao)

table(selecao$algorithm)
table(selecao$n_neighbors)
table(selecao$metric)
table(selecao$sizes)


#---------------------------------------------------------------------

# Destes remanescentes, seleção daqueles com menor tamanho de imagem 
# e menor numero de vizinhos

selecao2 <- subset(selecao, 
                   sizes == min(selecao$sizes) & 
                     n_neighbors == min(selecao$n_neighbors))

nrow(selecao2)

#---------------------------------------------------------------------

