### DEFINIÇÃO DO PROBLEMA

#Precisamos entender os gastos com viagens a serviço para tomar medidas mais eficientes e, com isso, reduzir os custos das viagens a serviço.

#Vamos levantar algumas questões relevantes acerca dessa problemática:

# Qual é o valor gasto por órgão?
# Qual é o valor gasto por cidade?
# Qual é a quantidade de viagens por mês?


### OBTENÇÃO DOS DADOS

?read.csv

getwd() # Verifica o diretório de trabalho atual
setwd("C:\\Users\\Janine\\Documents\\Material Complementar-20240528") # Define o diretório de trabalho



library(readr)

# Definindo a locale para lidar com a codificação latin1
locale <- locale(encoding = "ISO-8859-1", decimal_mark = ",", grouping_mark = ".")

# Lendo o arquivo CSV com as configurações de locale
viagens <- read_csv2(
  file = "C:\\Users\\Janine\\Documents\\Material Complementar-20240528\\2019_Viagem.csv",
  locale = locale
)

# Mostrando as primeiras linhas do dataframe
print(head(viagens))

# Verificar dimensões do dataset
dim(viagens)

# Resumo do dataset - valores min, max, media, mediana
summary(viagens)

#Summary de uma coluna específica
summary(viagens$'Valor passagens')

# Verificar tipo dos dados
install.packages("dplyr")
library(dplyr)
glimpse(viagens)


# Transformação dos dados obtidos

?as.Date

viagens$data.inicio <- as.Date(viagens$`Período - Data de início`, "%d/%m/%Y")

glimpse(viagens)

# Formatando a data de início para utilizar somente Ano/Mês
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

# Verificando os valores min, max e média
summary(viagens$`Valor passagens`)

#Visualizando os valores em um boxplot
boxplot(viagens$`Valor passagens`)

# Calculando o desvio padrão
sd(viagens$`Valor passagens`)

# Verificar se existem valores não preenchidos nas colunas
?is.na

?colSums

colSums(is.na(viagens))

# Verificar a quantidade de categorias da coluna situação

viagens$Situação <- factor(viagens$Situação)

str(viagens$Situação)

# Verificar quantidade de registros em cada categoria
table(viagens$Situação)

# Obtendo os valores em percentual de cada categoria
prop.table(table(viagens$Situação)) *100

### Visualizando os resultados

# 1 - Qual é o valor gasto por órgão em passagens?

library(dplyr)
p1 <- viagens %>%
  group_by(`Nome do órgão superior`) %>%
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
  labs(x = "Valor", y = "Órgãos")

# 2 - Qual é o valor gasto por cidade?

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

#Criando o gráfico
ggplot(p2, aes(x = reorder(destino, valor), y = valor))+
  geom_bar(stat = "identity", fill = "#0ba791")+
  geom_text(aes(label = valor), vjust = 0.3, size = 3)+
  coord_flip()+
  labs(x = "Valor", y = "Destino")

#options(scipen = 999)

# 3 - Qual é a quantidade de viagens por mês?

#Criando um dataframe com a quantidade de viagens por Ano/mês
p3 <- viagens %>%
  group_by(data.inicio.formatada) %>%
  summarise(qtd = n_distinct(`Identificador do processo de viagem`))

head(p3)

#Criando o gráfico
ggplot(p3, aes(x = data.inicio.formatada, y = qtd, group = 1))+
  geom_line()+
  geom_point()

