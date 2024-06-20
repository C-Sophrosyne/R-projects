#Vetores

#Criando um vetor

?c()

cidade <-c("Brasília",
           "São Paulo",
           "Rio de Janeiro",
           "Porto Alegre")


#Para visualizar os dados do vetor
cidade

temperatura <-c(32, 22, 35, 17)

regiao <-c(1, 2, 2, 3)

#Acessando o primeiro elemento
cidade[1]

#Acessando um intervalo de elementos
temperatura[1:3]

#Copiando um vetor
cidade2 <- cidade
cidade2

#Excluindo o segundo elemento da consulta
temperatura[-2]

#Alterando um vetor
cidade2[3] <- "Belo Horizonte"

#Adicionando um novo elemento
cidade2[5] <- "Curitiba"

#Deletando o vetor
cidade2 <- NULL
cidade2
