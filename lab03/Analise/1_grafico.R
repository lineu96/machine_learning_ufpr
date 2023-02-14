
#---------------------------------------------------------------------
# Gráfico para avaliação do f1_score para cada cenário
#---------------------------------------------------------------------

x11()

library(ggplot2)

data_graph <- data

data_graph$batch_size <- as.factor(data_graph$batch_size)

data_graph$learning_rate <- as.factor(data_graph$learning_rate)
levels(data_graph$learning_rate) = c('LR = 0.01',
                                     'LR = 0.1',
                                     'LR = 0.5')

data_graph$rede <- factor(data_graph$rede,
                          levels = c("lenet5", "alexnet", "xception", "mobilenetv2"))
levels(data_graph$rede) <- c('Lenet5', 'AlexNet', 'Xception', 'MobileNetV2')

data_graph$base <- factor(data_graph$base,
                          levels = c("original", "aumentada"))
levels(data_graph$base) <- c('Treino original', 'Treino aumentado')


g1<-ggplot(data_graph[,c(1,2,3,4,6)], 
  #subset(data_graph, base == 'Treino original'),
           aes(x=epochs, 
               y=accuracy, 
               col = factor(batch_size)))+ 
  theme_bw()+
  theme(legend.position = 'bottom',
        legend.title = element_text(size=12, face="bold", ),
        legend.text = element_text(size=12, face="bold"),
        strip.text.x = element_text(size=12, face="bold"),
        strip.text.y = element_text(size=12, face="bold"),
        axis.text.x=element_text(size=11),
        axis.text.y=element_text(size=11))+
  geom_point(position=position_dodge(width=0.9))+
  xlab('Épocas') + 
  ylab('Acurácia')+
  scale_colour_discrete("Batch size")+
  #scale_x_discrete(breaks = seq(100,500,200))+
  scale_x_continuous(breaks = seq(100,500,200),
                     limits = c(50,550))+
  #facet_grid(learning_rate~rede+base)
  facet_grid(learning_rate~rede)

g1

ggsave(filename='fig.png', 
       plot=g1, device="png", 
       path=getwd(),
       dpi=500, 
       height = 6, width = 9)

#---------------------------------------------------------------------