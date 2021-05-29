#---------------------------------------------------------------------

# LAB 01

#---------------------------------------------------------------------

# Expand grid para gerar todas as combinações dos experimentos

sizes <- c(5,10,20,30,40)

n_neighbors <- c(1,5,10,20,50)

metric <- c('chebyshev', 'euclidean', 'manhattan'#, 'mahalanobis'
)

algorithm <- c('auto', 'ball_tree', 'kd_tree', 'brute')

digit <- 0:9

experiments <- expand.grid(digits = digit,
                           algorithm = algorithm,
                           n_neighbors = n_neighbors,
                           metric = metric,
                           sizes = sizes
)

nrow(experiments)
names(experiments)

#write.csv2(experiments, 'experiments.csv')

#---------------------------------------------------------------------

# Leitura dos dados

data <- read.csv2('experiments.csv', header =T, sep = ',', dec = '.')
nrow(data)
summary(data)

#---------------------------------------------------------------------
