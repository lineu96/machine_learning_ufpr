#---------------------------------------------------------------------

# LAB 03

#---------------------------------------------------------------------

# Expand grid para gerar todas as combinações dos experimentos

rede <- c('lenet5',
          'alexnet',
          'xception',
          'mobilenetv2')

batch_size <- c(64,128,256)

epochs <- c(100,300,500)

learning_rate <- c(0.01, 0.1, 0.5)

base <- c('original', 'aumentada')

experiments <- expand.grid(batch_size = batch_size,
                           epochs = epochs,
                           learning_rate = learning_rate,
                           rede = rede,
                           base = base
)

nrow(experiments)
names(experiments)

#write.csv2(experiments, 'experiments.csv')

#---------------------------------------------------------------------

# Leitura dos dados

data <- read.csv2('experiments.csv', header =T, sep = ';', dec = '.')
nrow(data)
summary(data)

#---------------------------------------------------------------------
