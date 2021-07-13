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

# Variables

# En este ej. trabajaremos con la variable "ideology". Nuestra pregunta de investigacion es que hace que la gente tenga la ideologia que tiene?
hist(dat$ideology)

# Para pensar esta pregunta, estimaremos el siguiente modelo:
# Variable dependiente (y): "ideology".
# Variable independiente 1 (x1): "income".
# Variable independiente 2 (x2): "education".
# Variable independiente 3 (x3): "age".


# 1. Usando el comando "lm" estima un modelo lineal con las tres variables independientes. 
modelo = lm(ideology ~ income + education + age, dat)

# 1.1 Interpreta los coeficientes. Que podemos aprender del modelo? usa "summary(modelo)"
summary(modelo)

# Interpretar TODOS los coeficientes.
## cuando income sube una unidad, ideologia sube en 0.0370210 (se vuelve mas derechista)
## cuando education sube en una unidad, ideologia baja en -0.0679199 (se vuelve mas izquierdista).
## cuando age sube en una unidad, ideologia sube en 0.0063819 (se vuelve mas izquierdista).


# 1.2 Interpreta la significancia estadistica de los coeficientes.
## Todos los coeficientes son significativos.


# 1.3 Chequea la normalidad de los residuos.
hist(modelo$residuals) # histograma normal.

## 1.4 Computa el promedio de los residuos. Comenta. Se cumple el supuesto?
mean(modelo$residuals) # promedio cero. Si, se cumple.


## Interpretacion: aunque los residuos se ven mal distribuidos, tienen promedio cero lo que los hace suficientemente buenos.

# 2. Terminos de interaccion. 
## 2.1 Estima un nuevo modelo usando un termino de interaccion. El modelo debe ser del tipo" y ~ b0 + b1x1 + b2x2 + b3x3 + b4x1*x2"
modelo.int = lm(ideology ~ income + education + age + income*education, dat)

## 2.2 Interpreta b4
library(effects)
term.int <- effect("income*education", modelo.int) 
plot(term.int, as.table=T)

# Interpretacion: la ideologia sube mas rapidamente (se vuelve mas derechista) a medida que el ingreso sube y la educacion es baja (1). Y asi sucesivamente. Se espera que el estudiante interprete el panorama general (no todos los recuadros).

