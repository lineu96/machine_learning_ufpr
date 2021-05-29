
#---------------------------------------------------------------------
# Gráfico para avaliação do f1_score para cada cenário
#---------------------------------------------------------------------

x11()

ggplot(subset(data#, data$algorithm == 'auto'
              ), 
       aes(x=factor(digit), 
           y=f1_score, 
           col = algorithm,
           #size = metric,
           #shape = metric,
           #alpha = ,
))+ 
  theme_bw() + #ylim(c(-1,2.5))+
  theme(legend.position = 'bottom')+
  geom_point(position=position_dodge(width=0.9))+
  xlab('') + 
  ylab('Precision')+
  facet_grid(n_neighbors~metric+sizes, scales = 'free')

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