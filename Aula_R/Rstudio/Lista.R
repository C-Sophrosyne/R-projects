#Listas
?list()

pessoa <- list(sexo = "M", cidade = "Brasília", idade = 20)
pessoa

#Acessando o primeiro elemento da lista
pessoa[1]

#Acessando o valor do primeiro elemento da lista
pessoa[[1]]

#Editando a lista
pessoa[["idade"]] <- 22
pessoa

#Deletando elemento da lista
pessoa[["idade"]] <- NULL
pessoa

#criando novamente a lista
pessoa <- list(sexo = "M", cidade = "Brasília", idade = 20)

#Filtrando elementos da lista
pessoa[c("cidade", "idade")]

#Lista de listas
cidades <- list(cidade = cidade,
                temperatura = temperatura,
                regiao = regiao)
cidades

#Criando um data frame com vetores

df <- data.frame(cidade, temperatura)
df

df2 <- data.frame(cidades)
df2

#Filtrando valores do data frame
#Recuperando o valor da linha 1, coluna 2
df[1,2]

#Recuperando todas as linhas da primeira coluna
df[, 1]

#Recuperando a primeira linha e todas as colunas
df[1,]

#Selecionando as 3 primeiras linhas da primeira e última coluna
df2[c(1:3), c(1,3)]

#Verificando o nome das colunas
names(df)

#Verificando o numero de linhas x colunas
dim(df)

#Verificando os tipos de dados
str(df)

#Acessar uma coluna do dataframe
df$cidade
df['cidade']

?matrix()

#Matrizes

#Criando uma matriz

m <- matrix(seq(1:9), nrow = 3)
m

m2 <- matrix(seq(1:25),
             ncol = 5,
             byrow = TRUE,
             dimnames = list(c(seq(1:5)),
                             c('A','B','C', 'D', 'E'))
              )

m2

#Filtrando a matriz
m2[c(1:2), c('B', 'C')]
