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
modelo.1 = lm(y1 ~ x1, anscombe)
## modelo.2 = y2 ~ x1
modelo.2 = lm(y2 ~ x1, anscombe)
## modelo.3 = y3 ~ x1
modelo.3 = lm(y3 ~ x1, anscombe)
## modelo.4 = y4 ~ x4
modelo.4 = lm(y4 ~ x4, anscombe)

### 1.2 Usando la base "dat", estima el siguientee modelo usando el comando "lm"
## modelo.5 = V2 ~ V1
modelo.5 = lm(V2 ~ V1, dat)


# 2. Muestra tus resultados en una tabla. 
library(texreg)
screenreg(list(modelo.1, modelo.2, modelo.3, modelo.4, modelo.5))


# 3. Post-estimation checklist:
# 3.1 El error tiene promedio cero?
mean(modelo.1$residuals) # si.
mean(modelo.2$residuals) # si.
mean(modelo.3$residuals) # si.
mean(modelo.4$residuals) # si.
mean(modelo.5$residuals) # si.


# El estudiante no solo debe concluir que el promedio es cero usando la funcion "mean" (o "summary"). Tambien debe plotear los errores. Puntos extra si el estudiante considera plotear la linea.
plot(modelo.1$fitted.values, modelo.1$residuals)
plot(modelo.2$fitted.values, modelo.2$residuals)
plot(modelo.3$fitted.values, modelo.3$residuals)
plot(modelo.4$fitted.values, modelo.4$residuals)
plot(modelo.5$fitted.values, modelo.5$residuals)


# 3.2 El error tiene varianza constante?
## Segun los graficos, debe concluir que NO tiene varianza constante.

# Otra manera es la siguiente. Sin embargo, la evidencia aqui no es conclusiva.
library(car)
crPlot(modelo.1, "x1") 
crPlot(modelo.2, "x1") 
crPlot(modelo.3, "x1") 
crPlot(modelo.4, "x4") 
crPlot(modelo.5, "V1") 



# 3.3 El error no esta correlacionado?
## Segun los graficos debe concluir que claramente estan correlacionados (porque hay un patro).

# 3.4 El error esta normalmente distribiuido?
## Segun los graficos debe concluir que claramente NO estan normaomente distribuidos.

# 3.5 Las X's no son invariables, es decir, las X's son variables, no constantes?
## Las X's si varian.


# Puntos extra si el/la estudiante comprende que debe SIEMPRE plotear los residuos y las variables a regresar. No basta con correr "mean" (porque aunque de 0, siempre puede existir la posibilidad de que igual haya un patron, como es este el caso).
plot(y1 ~ x1, anscombe)
plot(y2 ~ x1, anscombe)
plot(y3 ~ x1, anscombe)
plot(y4 ~ x4, anscombe)
plot(V2 ~ V1, dat)









