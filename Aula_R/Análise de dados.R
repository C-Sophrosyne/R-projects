### DEFINI��O DO PROBLEMA

#Precisamos entender os gastos com viagens a servi�o para tomar medidas mais eficientes e, com isso, reduzir os custos das viagens a servi�o.

#Vamos levantar algumas quest�es relevantes acerca dessa problem�tica:

# Qual � o valor gasto por �rg�o?
# Qual � o valor gasto por cidade?
# Qual � a quantidade de viagens por m�s?


### OBTEN��O DOS DADOS

?read.csv

getwd() # Verifica o diret�rio de trabalho atual
setwd("C:\\Users\\Janine\\Documents\\Material Complementar-20240528") # Define o diret�rio de trabalho



library(readr)

# Definindo a locale para lidar com a codifica��o latin1
locale <- locale(encoding = "ISO-8859-1", decimal_mark = ",", grouping_mark = ".")

# Lendo o arquivo CSV com as configura��es de locale
viagens <- read_csv2(
  file = "C:\\Users\\Janine\\Documents\\Material Complementar-20240528\\2019_Viagem.csv",
  locale = locale
)

# Mostrando as primeiras linhas do dataframe
print(head(viagens))

# Verificar dimens�es do dataset
dim(viagens)

# Resumo do dataset - valores min, max, media, mediana
summary(viagens)

#Summary de uma coluna espec�fica
summary(viagens$'Valor passagens')

# Verificar tipo dos dados
install.packages("dplyr")
library(dplyr)
glimpse(viagens)


# Transforma��o dos dados obtidos

?as.Date

viagens$data.inicio <- as.Date(viagens$`Per�odo - Data de in�cio`, "%d/%m/%Y")

glimpse(viagens)

# Formatando a data de in�cio para utilizar somente Ano/M�s
?format
viagens$data.inicio.formatada <- format(viagens$data.inicio, "%Y-%m")
viagens$data.inicio.formatada

# Explorando dados e gerando histograma

hist(viagens$`Valor passagens`)

# filtrando valores
?dplyr::filter
?dplyr::select

# Filtrando apenas passagens entre 200 - 5000
passagens_filtro <- viagens %>%
  select(`Valor passagens`) %>%
  filter(`Valor passagens` >= 200 & `Valor passagens` <= 5000)

passagens_filtro
hist(passagens_filtro$`Valor passagens`)

# Verificando os valores min, max e m�dia
summary(viagens$`Valor passagens`)

#Visualizando os valores em um boxplot
boxplot(viagens$`Valor passagens`)

# Calculando o desvio padr�o
sd(viagens$`Valor passagens`)

# Verificar se existem valores n�o preenchidos nas colunas
?is.na

?colSums

colSums(is.na(viagens))

# Verificar a quantidade de categorias da coluna situa��o

viagens$Situa��o <- factor(viagens$Situa��o)

str(viagens$Situa��o)

# Verificar quantidade de registros em cada categoria
table(viagens$Situa��o)

# Obtendo os valores em percentual de cada categoria
prop.table(table(viagens$Situa��o)) *100

### Visualizando os resultados

# 1 - Qual � o valor gasto por �rg�o em passagens?

library(dplyr)
p1 <- viagens %>%
  group_by(`Nome do �rg�o superior`) %>%
  summarise(n = sum(`Valor passagens`)) %>%
  arrange(desc(n)) %>%
  top_n(15)

# Alterando o nome das colunas
names(p1) <- c('orgao', 'valor')

p1

# Plotando os dados
library(ggplot2)
ggplot(p1, aes(x = reorder(orgao, valor), y= valor))+
  geom_bar(stat = "identity")+
  coord_flip()+
  labs(x = "Valor", y = "�rg�os")

# 2 - Qual � o valor gasto por cidade?

#Criando um dataframe com as 15 cidades que gastam mais
p2 <- viagens %>%
  group_by(Destinos) %>%
  summarise(n = sum(`Valor passagens`)) %>%
  arrange(desc(n)) %>%
  top_n(15)

p2

#Alterando o nome das colunas
names(p2) <- c("destino", "valor")
p2

#Criando o gr�fico
ggplot(p2, aes(x = reorder(destino, valor), y = valor))+
  geom_bar(stat = "identity", fill = "#0ba791")+
  geom_text(aes(label = valor), vjust = 0.3, size = 3)+
  coord_flip()+
  labs(x = "Valor", y = "Destino")

#options(scipen = 999)

# 3 - Qual � a quantidade de viagens por m�s?

#Criando um dataframe com a quantidade de viagens por Ano/m�s
p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(`Identificador do processo de viagem`))

head(p3)

#Criando o gr�fico
ggplot(p3, aes(x = data.inicio.formatada, y = qtd, group = 1))+
  geom_line()+
  geom_point()

