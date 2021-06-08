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

g1<-ggplot(data=data, 
           aes(x=train_size, 
               y=X.2,
               col = classificador)) +
  geom_line() +
  geom_point() +
  theme_bw()+
  geom_point(position=position_dodge(width=0.9))+
  xlab('Nº de exemplos no treino') + 
  ylab('Acurácia no teste')+
  theme(#legend.position = 'bottom',
    legend.title = element_text(size=12, face="bold", ),
    legend.text = element_text(size=12, face="bold"),
    strip.text.x = element_text(size=12, face="bold"),
    strip.text.y = element_text(size=12, face="bold"),
    axis.text.x=element_text(size=11),
    axis.text.y=element_text(size=11)
  )

ggsave(filename='fig.png', 
       plot=g1, device="png", 
       path=getwd(),
       dpi=500, 
       height = 8, width = 16.5)

#---------------------------------------------------------------------