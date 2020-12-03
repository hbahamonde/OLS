# PS 2

# Nombre:
# Fecha:
# Prof. Héctor Bahamonde.
# Ayudante: Gonzalo Barría.
# Fecha entrega: una semana de plazo desde su fecha de publicacion en uCampus (Tareas).


# Carga la base
library(foreign) # significa "foraneo"
options(scipen = 1000000) # apagar notacion cientifica.
dat = read.dta("https://github.com/hbahamonde/OLS/raw/master/Datasets/obama.dta")

# "Obamafav": escala donde mas significa que mas le gusta Obama.
# "partyid": ident. partidaria.
# "ideology": escala donde mas significa mas de derecha.
# "income": ingresos (en factor).
# "education": educacion (en factor). 
# "age": edad (numerica).
# "sex": genero (factor). male = "hombre", female = "mujer".


# Resumen
summary(dat)

# En este ej. trabajaremos con la variable "ideology". Nuestra pregunta de investigacion es que hace que la gente tenga la ideologia que tiene?
hist(dat$ideology)

# Para pensar esta pregunta, estimaremos el siguiente modelo:
# Variable dependiente (y): "ideology".
# Variable independiente 1 (x1): "income".
# Variable independiente 2 (x2): "education".
# Variable independiente 3 (x3): "age".


# 1. Usando el comando "lm" estima un modelo lineal con las tres variables independientes. 


## 1.1 Interpreta los coeficientes. Que podemos aprender del modelo? usa "summary(modelo)"



## 1.2 Interpreta la significancia estadistica de los coeficientes.


## 1.3 Chequea la normalidad de los residuos.


## 1.4 Computa el promedio de los residuos. Comenta. Se cumple el supuesto?





# 2. Terminos de interaccion. 

## 2.1 Estima un nuevo modelo usando un termino de interaccion. El modelo debe ser del tipo" y ~ b0 + b1x1 + b2x2 + b3x3 + b4x1*x2"


## 2.2 Usando metodos graficos interpreta b4



