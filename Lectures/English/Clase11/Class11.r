# Error, residual and e.
#################################################################
cat("\014")
rm(list=ls())
graphics.off()

# In this class we will work with a famous dataset called 
# "Correlates of War." This data is widely used to study war. 

# Today, we are going to think about the following question: What's the relationship
# between Political Repression and Democracy. 

# Do we have an idea about what this relationship could look like, and why?

# OK---The unit of analysis is the country. Our research question is:
# Which kind of country represses more, democratic ones or dictatorships? To
# answer this question, we will estimate a linear model. Particularly,
# we will look at beta1.

# Let's open the dataset. Files in .dta format are Stata data files. This is
# one of the many advantages of R: R will read Stata files, but Stata WILL NOT
# read R files. 

# Load pacman
if (!require("pacman")) install.packages("pacman"); library(pacman)

# Load the package to load dataset that aren't R datasets.
p_load(foreign) 
options(scipen = 1000000) # apagar notacion cientifica.
dat = read.dta("https://github.com/hbahamonde/OLS/raw/master/Datasets/cow.dta")

# Always inspect the dataset
head(dat)

# country Country Name
# ccode: country code
# pop: Population in thousands
# rgdpch: Real GDP/capita
# democracy: measure of democracy 
# vdiss: Violent dissent based on terrorist events and fatalities.
# repression: Violations of physical integrity rights.

# Another trick: plot the entire dataset.
plot(dat)

########################
# Simple OLS model
########################

# Let's estimate a simple "bivariate" model, that is, just one independent variable (X).
# Notice that there is ALWAYS just ONE dependent variable (Y).

biv.model = lm(repression ~ democracy, dat)
summary(biv.model) 

# Today we're just looking at the coefficients (betas). We will soon look at the std. errors.

# (1) How can we interpret these results?
# (2) How can we write this relationship in mathematical notation?
# (3) How can we write this in matrix form?

# Let's check the PDF guide. 

# Let's calculate the error. That's the difference between what we estimate (y')
# and what we observe (y). 

# First, let's calculate y' ("predicted y"=="y prime"=="y hat").
dat$repression.prime = predict.lm(biv.model)

# Second, let's calculate the error manually
dat$error = dat$repression-dat$repression.prime

# Luckily, the object "biv.model" already has that vector in it.
as.numeric(biv.model$residuals)

# Let's see...
head(dat)

# OK, all these imply that:
# 1. There are better models than others. The "best" models are the ones with less error.
# 2. The error represents all the things we cannot, should not or cannot afford to measure, examples?
# 3. The error is normally distributed, and it should have mean 0.
# 4. Philosophically: what we don't know (our ignorance), is not systematic (e.g., we make mistakes at random).
# 5. Mathematically: what we we don't know (our ignorance), has zero effect on our model (e.g. its mean is 0).

# Deep stuff right here...

# Let's think harder about these questions:
# Some qualitative researchers criticize quantitative models because OLS models have "errors."
# 1) Is it possible to have perfect model, e.g. without error?
# 2) Is it too bad if we have errors?
# 3) Many people say "errors cancel each other out"...they're right. But what does it mean?

# Let's plot the error
p_load(lattice) # Library for plots
densityplot(dat$error)
# OK---good. Very close to 0.

# Let's see it in more detail:
summary(dat$error) # What's the mean? 

# Let's compare the error we computed manually with the one R gives us.
round(median(dat$error),4) == round(median(biv.model$residuals),4)

# It's always good to plot your errors: ALWAYS INSPECT THEM VISUALLY.
# Let's use a "scatter plot" for that. 
# These plots are good to plot two continuous variables, one in each axis (e.g. X and Y).
# Actually, we want to inspect how the error behaves at different values of y'.

plot(biv.model$residuals, biv.model$fitted.values)

# What do we want? "Homoscedastic" errors.
# That is, errors with CONSTANT VARIANCE. 
# The opposite is when we have "heteroskedastic" errors (non-constant variance errors).
# We don't want that. 

# (1) How does it look like when we are in trouble? ("heteroskedasticity")
# (2) How can we re-think about this concept, "normally distributed errors with mean 0"?
# (3.1) A "good" error doesn't have a clear pattern. 
# (4) Why do we have errors in our models anyways?

########################
# Multivariate Regression
########################

# "Multiple" o "multivariate" regression has more than one X.
# HERE

# Pensemos en la idea de que una variable sea "independiente".
# Para ello, pensemos en nuestra ecuacion lineal de nuevo.

# y = b0 + b1x1 + e (esta es bivariada: una "x")
# y = b0 + b1x1 + b2x2 + b3x3 + e ("multivariada" o "multiple").


# (1) Por que se llama "independiente"?
# (2) Importa en que orden vayan las variables?
# (3) Cuantas variables independientes podemos tener?
# (4) Que variables independientes NO PODEMOS tener?

# (4.1) No podemos poner la misma variable a los dos lados del "="
# Es decir, no podemos estimar "y ~ y" (o "x ~ x").

# Pensemos en las notas del ramo de Matematicas de A y B.
pj = data.frame(
  name=c("A", "B"),
  grade.math=c(3,5)
)

pj # ve como se ve el objeto "pj".

lm(pj$grade.math ~ pj$grade.math) # Error


# (4.2) La misma variable independiente dos veces:

# Es decir, y = x1 + x1 NO SE PUEDE. Veamos por que.

# Volvamos a A y B (y dejemos a Diego fuera mientras).

# Pensemos nuevamente en las notas en Matematicas de A y B.
data.frame(
  name=c("A", "B"),
  grade.math=c(3,5)
)

# Ahora, entremos las notas de A y B en una matriz DOS VECES.
# La matriz se llama "x".
x = matrix(
  c(3,5,3,5),
  ncol = 2
)
x

# Fijate que la primera y la segunda columna significan lo mismo ("notas en matematicas").


# Volvamos al modelo. Queremos ver que la ecuacion de regresion con dos variables
# independientes que son identicas es imposible. Es decir, esto es imposible:

# y = b0 + b1x1 + b2x1 + e
# donde "x1" es "Notas en Matematicas" (fijate que x1 que entro dos veces).

# Tratemos de estimar los betas via matrices.
# (x'x)^-1x'y (esta es la formula...solo para recordar).
# Ahora veamos si es posible hacer esto cuando estimamos el modelo x = x.

# Transponer x
t(x) # Ok, es posible

# Multiplicar x'x
t(x) %*% x # Ok, es posible

# Ahora, siguiendo la formula, tratemos de inviertir (x'x)
library(matlib) # para invertir matrices
inv(t(x) %*% x) # Matriz no es invertible
## Esto significa que la determinante de la matriz es 0.



# Es por esto que lm() no sabe muy bien que hacer con este problema. Veamos.

## Intento 1
summary(lm(repression ~ democracy + democracy, dat)) # Que paso aqui?

# Forcemos a R a hacerlo
# Intento 2
dat$democracy2 = dat$democracy # Enganando a R...
summary(lm(repression ~ democracy + democracy2, dat)) # Que paso aqui?

# Nuevamente det(x'x)=0.

# Tecnicamente, aqui tenemos problemas de "colinearidad perfecta"

# Ejemplo 1: Colinearidad Perfecta (de nuevo)
m1 = matrix(c(3,5,3,5), ncol = 2) # Define matrix "m"
m1 # ve como se ve la matrix "m1"

# El resultado sera muy cercano a 0, y sera un numero muy 
# pequeno, por lo que debemos apagar la notacion cientifica

options(scipen=10000) # Apaga la notacion cientifica

# toma la determinante de matrix "m1"
det(m1) # da practicamente 0. Eso es "malo" (la matriz no es invertible).


# Ejemplo 2: Multicolinearidad (que es diferente a Colinearidad Perfecta)
# Colinearidad perfecta, es precisamente eso, "perfecta"
# Multicolinearidad es la version mas ligera de "colinearidad perfecta".

# ejemplo
m2 = matrix(c(3,5,6,10), ncol = 2) # Define matrix "m"

m2 # llama a la matrix "m2" para verla

# Notan algo especial en esta matrix?

# el segundo vector de x2 es una "combinacion lineal" del primer
# vector: cual combinacion lineal?


# El resultado sera muy cercano a 0, y sera un numero muy 
# pequeno, por lo que debemos apagar la notacion cientifica

options(scipen=10000) # Apaga la notacion cientifica

# toma la determinante de matrix "m"
det(m2) # mismo problema. |m2| = 0, o "la determinante de m2 es cero, 
# por lo que m2 no es invertible"


# En ambos ejemplos ("m1" y "m2"), si la determinante es 0, la matrix no es
# invertible, y no podemos hacer la regresion.

# (1) En que casos REALES podemos tener problemas de 
# colinearidad perfecta?

# (2) Por que es MUY COMUN tener problemas de colinearidad "imperfecta" (o "multicolinearidad")
# en ciencias sociales?

# OK, sigamos.

# Estimemos un modelo lineal multivariado.

# (1) Que mas podria ser importante para explicar/predecir represion?

colnames(dat) # "column names)

# "pop" (poblacion)?
# "rgdpch" (crecimiento economico)?
# "vdiss" (terrorismo)?



multivariate.model = lm(repression ~ democracy + pop + vdiss, dat) # Completar


summary(multivariate.model) # Hoy solo miraremos los coeficientes. Otro dia veremos el error std.




# Primero, calculemos y'
dat$repression.prime2 = predict.lm(multivariate.model)

# Segundo, calculemos el error:
dat$error2 = multivariate.model$residuals
# lo que predecimos (predict.lm(multivariate.model)) y lo que observamos (dat$repression).

# Veamos...
head(dat)

# Graficando el error: Densidad
p_load(lattice) # Para graficos
densityplot(dat$error2)

# Ves un pastron o algo "inusual"?
plot(dat$repression.prime2, dat$error2)

# Funcion (que veremos mas adelante) para plotear diagnosticos. 
plot(multivariate.model)


# Summary ("Resumen")
summary(dat$error2)

# Pensemos en los coeficientes (los betas)

# (1) Como se leen los betas ahora que tenemos mas variables?
# (2) Que significa "constantes en el promedio"?  


########################
# Mostrar resultados: tabla y grafico (coefplot)
########################

# Incertidumbre es el fantasma de este curso. 
# Nunca sabemos si tenemos el "modelo verdadero".
# Es por esto que siempre hacemos mas de un modelo, y 
# mostramos mas de un modelo en nuestro trabajo. 

# Hagamos una tabla para mostrar nuestros resultados.

p_load(texreg) # paquete para hacer tablas con varios modelos.

screenreg( # funcion
  list( # ponemos los dos modelos en una lista, que es otro objeto que R ocupa.
    biv.model, # nuestro primer modelo
    multivariate.model # nuestro segundo modelo
  )
)

# (1) Como interpretamos esta tabla?

# Tambien podemos graficar nuestros coeficientes
p_load(coefplot)
multiplot(
  biv.model, # nuestro primer modelo univariado
  multivariate.model # nuestro segundo modelo multivariado
)

# (1) Como interpretamos esto?


# Planteado para la proxima clase: 
## (a) intervalos de confianza.
## (b) linea de cero (significancia estadistica)