
#---------------------------------------------------------------------
# Gráfico para avaliação do f1_score para cada cenário
#---------------------------------------------------------------------

x11()

library(ggplot2)

data_graph <- data

data_graph$n_neighbors <- as.factor(data_graph$n_neighbors)
levels(data_graph$n_neighbors) <- c('k=1', 'k=5', 'k=10', 'k=20', 'k=50')

data_graph$sizes <- as.factor(data_graph$sizes)
levels(data_graph$sizes) <- c('5x5', '10x10', '20x20', '30x30', '40x40')

levels(data_graph$metric) <- c("Chebyshev", "Euclidean", "Manhattan")

g1<-ggplot(subset(data_graph), 
       aes(x=factor(digit), 
           y=f1_score, 
           col = algorithm))+ 
  theme_bw()+
  theme(legend.position = 'bottom',
        legend.title = element_text(size=12, face="bold", ),
        legend.text = element_text(size=12, face="bold"),
        strip.text.x = element_text(size=12, face="bold"),
        strip.text.y = element_text(size=12, face="bold"),
        axis.text.x=element_text(size=11),
        axis.text.y=element_text(size=11)
        #strip.background = element_rect(colour="red", fill="#CCCCFF")
        )+
  geom_point(position=position_dodge(width=0.9))+
  xlab('Dígito') + 
  ylab('F1 score')+
  scale_colour_discrete("Algoritmo")+
  scale_x_discrete(breaks = seq(0,9,2))+
  scale_y_continuous(breaks = seq(0,1,0.3))+
  facet_grid(n_neighbors~metric+sizes, scales = 'free')
  #facet_grid(metric+sizes~n_neighbors, scales = 'free')

ggsave(filename='fig.png', 
       plot=g1, device="png", 
       path=getwd(),
       dpi=500, 
       height = 8, width = 16.5)


#---------------------------------------------------------------------

# Sobre as medidas

# precision: daqueles que classifiquei como corretos, 
# quantos efetivamente eram?

# recall: dentre todas as situações de classe Positivo 
# como valor esperado, quantas estão corretas;

# f1: combina precisão e recall. Um número único que indica 
# qualidade geral. Trabalha bem até com classes desproporcionais.

# A precisão pode ser usada em uma situação em que os Falsos 
# Positivos são considerados mais prejudiciais que os Falsos Negativos.

# O recall pode ser usada em uma situação em que os Falsos 
# Negativos são considerados mais prejudiciais que os Falsos Positivos.

# O F1-Score é simplesmente uma maneira de observar somente 
# 1 métrica ao invés de duas (precisão e recall) em alguma situação. 
# quando tem-se um F1-Score baixo, é um indicativo de que ou a precisão 
# ou o recall está baixo.

#---------------------------------------------------------------------

# Conclusão do gráfico

##"metric": desempenho muito rum da distancia de chebychev

##"n_neighbors": queda de desempenho conforma cresce k

##"algorithm":sem diferença aparente entre algoritmos


##"sizes": para poucos vizinhos parece haver uma pequena melhora 
## de desempenho de 5, 10 para 20. 
## Apos 20 não verifica-se uma melhora muito significativa


## Indícios apontam que um cenário com poucos vizinhos e tamanho
# de imagem a partir de 20 devem ser os melhores. 
#Como não há diferença aparente entre algoritmos, deve-se optar pela m
# ais rápida (arvores)
# Quanto a distância, apenas a chebyshev se mostrou ruim

#---------------------------------------------------------------------