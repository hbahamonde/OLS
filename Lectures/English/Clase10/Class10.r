# Coefficients
#################################################################
cat("\014")
rm(list=ls())
graphics.off()

# Now we're going to another OLS model using matrix algebra techniques.

# While we've seen in class that coefficients are numbers, the emphasis 
# has been on just that. Yes, coefficients are numbers, but the important 
# issue is, What do these numbers mean? What should I do with them? Why are they
# important in quantitative social science?

# For now, remember (hopefully forever) the formula to derive the betas
# b = (x'x)^-1x'y

# Also, remember (hopefully forever) the formula to derive the lineal model
# y = b0 + b1x1 + e

# Using the formula for the betas, today we will calculate b0 (the intercept)
# and beta1 (coefficient).

# In this class we will think about the relationship between schooling and 
# prestige. 

# Question for you Is this relationship "positive" or "negative"? 
# To answer this question you should calculate b0 and b1. 

# Another question for you: what's the dependent variable? What's the independent variable?
# What "causes" what? (It's NOT a causal model, but we will say "cause" just for pedagogical purposes).

# Which one is it? And why?
# Schooling = Prestige ?
# Prestige = Schooling ?

# Ok---a coefficient, then, it's just the amount of change of one variable when the other changes. 

# This means that
# Prestige = b0 + b1*Schooling + e

# Remember, everything is "indexed", e.g. one value or number per observation (or person, in this example).
# Thus, the real equation is rather this one:
# Prestige_{i} = b0 + b1*Schooling_{i} + e_{i}
# where "i" in this case means "individual."
# Thus, every "i" has its own prestige and schooling levels (as well as the "e"rror level...we'll talk about that later...)

# So, this means we've got the following...

## Name    Schooling (x)    Prestige (y)   beta0      Beta1     Error
# -----------------------------------------------------------------------
## A        10                15            1         2         -6
## B        5                 10            1         2         ?
## C        2                 8             1         2         ?

## Recuerda (1): son los mismos betas para todos.
## Recuerda (2): Por ej., para el caso de Pedro, la formula 
## "Prestigio = b0 + b1Educacion + e", 
## o "Prestigio_{i} = b0 + b1Educacion_{i} + e_{i}", que es lo mismo, 
## seria asi:

## Pedro: 
## 15 = 1 + 2*10 - 6

######################################################################
## (1)
## Como seria para el caso de Juan y Diego?
## Responde
######################################################################

## Juan?


## Diego?

######################################################################
## OK; sigamos. Ahora carguemos una base de datos real.

if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(car) # En este paquete, "vive" la base "Prestige" ("Prestigio").

# Carga la base
data(Prestige)

# Mira como se ve la base de datos
head(Prestige)

# Extrae la 'x' para conseguir beta1
x = Prestige$education

# Ve como se ve "x"
x


## Recuerda que para conseguir beta0 debes anexar una columna de 1's.

## Aqui le decimos a R que repita 1s, del largo (o "lenght") de 'x'.
unos = rep(1,length(x)) 

# Ve como se ve "unos"
unos

# Ahora junta ambas cosas ("x" y "unos")

x = matrix(
  c(unos,x), # meter vectores 'unos' y 'x'
  ncol = 2 # y organizarlos en 2 columnas.
  )

x # mira como se ve la nueva matrix "x"
            
# Extrae la 'y'
y = matrix(Prestige$prestige)

y

######################################################################
## (2)
## Calcula beta0 y beta1
######################################################################

## Recuerda los operadores

# Transponer 
# t()

# Invertir
# inv()
## Recuerda cargar "matlib" para usar la funcion "inv()".
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(matlib)

# Multiplicar matrices
# Por ejemplo x*x es  x%*%x

# OK; ahora tu. Calcula b = (x'x)^-1x'y

######################################################################
# Problema
######################################################################

# Funciona
inv(t(x) %*% x) %*% t(x) %*% y

# No Funciona
inv(x) # Matrix debe ser cuadrada, pero "x" es rectancular.

# Por que?

inv(t(x) %*% x) # funciona
# Porque para multiplicar una matriz, debe ser CONFORMABLE.
# La dimension de "x" es 2x102 (dos columnas, 102 filas). Si "x" fuera 2x2, se podria.
# Sin embargo, al multiplicar x' (que es 102x2) y x (que es 2x102), por 
# el "inner rule" (no se el espanol), es decir, el 2 y el otro 2, 
# sabemos que la invertidad de x'x esta definida, porque x'x es cuadrado.


######################################################################
## (3) 
## Comprueba que hiciste todo bien.
## Estima una regresion lineal, pero ocupando
## el comando "lm" (por "linear model"). El comando "lm" se ocupa asi:
## lm(y ~ x). Define 'y' como 'Prestige$prestige' y 'x' como 'Prestige$education'.

modelo = lm(Prestige$prestige ~ Prestige$education)

options(scipen=9999)
summary(modelo)

######################################################################
## (4) Usando el comando 'plot', haz un grafico entre Prestigio y Educacion.
data(Prestige)



######################################################################
## (5) Usando tus propias palabras, y usando los resultados 
## de tu regresion lineal y el grafico, interpreta que significa
## beta0 y que significa beta1.



## (5.1) Que significa beta0? Responde.



## (5.2) Que significa beta1? Responde.


