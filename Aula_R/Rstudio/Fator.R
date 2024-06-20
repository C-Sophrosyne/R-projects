#Fatores

?factor

UF <- factor(c("DF", "SP", "RJ", "RS"))
UF

grau.instituicao <- factor(c("Nível Médio",
                             "Superior",
                             "Nível Médio",
                             "Fundamental"),
                           levels = c("Fundamental",
                                      "Nível médio",
                                      "Superior"),
                           ordered = TRUE)

grau.instituicao
