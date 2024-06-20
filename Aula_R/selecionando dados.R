library(dplyr)

data(iris)
head(iris)

# Visualizando o tipo de dados com o glimpse

glimpse(iris)

# Filter - filtrando dados - apenas versicolor

versicolor <- filter(iris, Species == "Versicolor")
versicolor
dim(versicolor)

#Slice - Selecionando algumas linhas especificas
slice(iris, 5:10)

#Select - selecionando algumas colunas
select(iris, 2:4)

# Selecionando todas as colunas exceto Sepal width
select(iris, -Sepal.Width)

#Criando uma nova colunas com base em colunas existentes (Sepal.Length + Sepal.Width)
iris2 <- mutate(iris, nova.coluna = Sepal.Length + Sepal.Width)
iris2[,c("Sepal.Length", "Sepal.Width", "nova.coluna")]

# Arrange - ordernar os dados
?arrange

select(iris, Sepal.Length) %>%
arrange(Sepal.Length)  

# Group by
?group_by

# Agrupando os dados - Tamanho médio da sépala por espécie
iris %>% group_by(Species) %>%
  summarise(mean(Sepal.Length))
