#---------------------------------------------------------------------

# LAB 02

#---------------------------------------------------------------------

# Expand grid para gerar todas as combinações dos experimentos

classificador <- c('KNeighborsClassifier', 
                   'GaussianNB',
                   'LinearDiscriminantAnalysis',
                   'LogisticRegression',
                   'Perceptron')

train_size <- seq(1000,20000,1000)

experiments <- expand.grid(classificador = classificador,
                           train_size = train_size
                           )

nrow(experiments)
names(experiments)

#write.csv2(experiments, 'experiments.csv')

#---------------------------------------------------------------------

data <- read.csv2('experiments.csv', header =T, sep = ',', dec = '.')
nrow(data)
summary(data)

#---------------------------------------------------------------------

# Gráfico

x11()

names(data)[1] <- 'Classificador'

g1<-ggplot(data=data, 
           aes(x=train_size, 
               y=accuracy,
               col = Classificador)) +
  geom_line(lwd=1.1) +
  geom_point(size=3) +
  theme_bw()+
  geom_point(position=position_dodge(width=0.9))+
  xlab('Nº de exemplos no treino') + 
  ylab('Acurácia no teste')+
  theme(legend.position = 'bottom',
    #legend.title = element_text(size=12, face="bold"),
    legend.title = element_blank(),
    legend.text = element_text(size=12, face="bold"),
    strip.text.x = element_text(size=12, face="bold"),
    strip.text.y = element_text(size=12, face="bold"),
    axis.text.x=element_text(size=11),
    axis.text.y=element_text(size=11)
  )

g2<-ggplot(data=data, 
           aes(x=train_size, 
               y=accuracy,
               col = Classificador)) +
  geom_line(lwd=1.1) +
  geom_point(size=3) +
  theme_bw()+
  geom_point(position=position_dodge(width=0.9))+
  xlab('Nº de exemplos no treino') + 
  ylab('Acurácia no teste')+
  theme(legend.position = 'none',
        #legend.title = element_text(size=12, face="bold"),
        #legend.title = element_blank(),
        legend.text = element_text(size=12, face="bold"),
        strip.text.x = element_text(size=12, face="bold"),
        strip.text.y = element_text(size=12, face="bold"),
        axis.text.x=element_text(size=11),
        axis.text.y=element_text(size=11)
  ) + facet_wrap(~Classificador)

ggsave(filename='fig.png', 
       plot=g1, device="png", 
       path=getwd(),
       dpi=500, 
       height = 10, width = 15)

ggsave(filename='fig2.png', 
       plot=g2, device="png", 
       path=getwd(),
       dpi=500, 
       height = 10, width = 15)

#---------------------------------------------------------------------