#Script para filtrar vértices da curva zero (ETTJ)
#Feito por: Marcelo Vilas Boas de Castro
#última atualização: 18/12/2020

#Definindo diretórios a serem utilizados
getwd()
setwd("C:/Users/User/Documents")

##Carregando pacotes que serão utilizados
library(tidyverse)
library(rio)
library(openxlsx)

#Importando planilha
  #Definindo as datas
datas <- import("curva_zero.xlsx", col_names = F)
datas <- datas[1,]
seleciona_datas <- seq(2,length(datas), 8)
datas_tratadas <- NA
for (i in 1:length(seleciona_datas)){
  datas_tratadas[i] <- datas[1,seleciona_datas[i]]
}
datas_tratadas <- convertToDate(datas_tratadas)

  #Coletando o resto dos dados
dados <- import("curva_zero.xlsx", col_names = F)
seleciona_coluna <- seq(4,length(dados), 8)

#Filtrando vértices de x anos (mudar de acordo com a linha onde está o vértice; ex. 2 anos = 10)
x_anos <- NA
for (i in 1:length(seleciona_coluna)){
  x_anos[i] <- as.numeric(dados[10,seleciona_coluna[i]])
}

#Filtrando vértices de y anos (vértice mais longo)
y_anos <- NA
for (i in 1:length(seleciona_coluna)){
  y_anos[i] <- as.numeric(dados[24,seleciona_coluna[i]])
}

#Juntando tudo
resultado <- data.frame(datas = datas_tratadas, x_anos, y_anos)
#Calculando y - x
resultado <- resultado %>% mutate(diferença = y_anos - x_anos) %>% arrange(datas)

#Exportando arquivo
export(resultado, "resultado.xlsx")