# Prof. Héctor Bahamonde.
# Ayudante: Gonzalo Barría.
# Fecha entrega: una semana de plazo desde su fecha de publicacion en uCampus (Tareas).

cat("\014")
rm(list=ls())
graphics.off()


options(scipen = 100000)
# Carga la base "anscombe"
library(datasets)
data(anscombe)
# Carga la base "dat"
library(foreign)
dat = read.csv("https://github.com/hbahamonde/OLS/raw/master/Datasets/saurus.csv", header=F) 



# En este ej tendras la oportunidad de trabajar en dos bases de datos ("anscombe" y "dat"). Armado/a con todo lo que tengas para analizar un modelo, quiero que veas si los cinco modelos que estimaras cumplen con los supuestos de la regresion lineal (Gauss-Markov). 

# Usa todas las herramientas que TU creas convenientes!

# Interpreta los cinco modelos. Y despues, por cada uno de los modelos, deberas responder las siguientes preguntas.

# a. El error tiene promedio cero?
# b. El error tiene varianza constante?
# c. El error no esta correlacionado?
# d. El error esta normalmente distribiuido?
# e. Las X's no son invariables, es decir, las X's son variables, no constantes?


# 1. Modelos

### 1.1 Usando la base "anscombe", estima los siguientes modelos usando el comando "lm"
## modelo.1 = y1 ~ x1
## modelo.2 = y2 ~ x1
## modelo.3 = y3 ~ x1
## modelo.4 = y4 ~ x4

### 1.2 Usando la base "dat", estima el siguientee modelo usando el comando "lm"
## modelo.5 = V2 ~ V1


# 2. Muestra tus resultados en una tabla. 
# library(texreg)
# screenreg(list(modelo.1, modelo.2, modelo.3, modelo.4, modelo.5))


# 3. Post-estimation checklist:
# 3.1 El error tiene promedio cero?
# 3.2 El error tiene varianza constante?
# 3.3 El error no esta correlacionado?
# 3.4 El error esta normalmente distribiuido?
# 3.5 Las X's no son invariables, es decir, las X's son variables, no constantes?






