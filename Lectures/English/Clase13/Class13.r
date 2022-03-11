# Hypothesis Testing (t test), Errors Type I and II, Statistical Significance (p-values)
#################################################################
cat("\014")
rm(list=ls())
graphics.off()

#################################################################
# Motivation
#################################################################

# So far we know how to interpret the coefficients and the std. errors.
# We also know what confidence intervals are and its relationship
# with the std. errors. However, we still need to know what those stars
# are every time we do a summary(model).

# This is what we are goint to learn now. The betas are the size of effect.
# However, since we live in an *inferential* world, there is always a chance or 
# probability that the effect is actually ZERO!
# For instance, say some beta1 = 25, there is a chance that that in reality 
# beta1 = 0. 

# How can we be compute this uncertainty? How can be "sure" that beta1 is NOT 0?

# Part of the answer relies on the concept of confidence interval. 

#################################################################
# Let's estimate a model.
#################################################################

# install.packages("foreign")
library(foreign) 
options(scipen = 1000000)
dat = read.dta("https://github.com/hbahamonde/OLS/raw/master/Datasets/cow.dta")

# Let's motivate this problem with the following question:
# What explains the size of a population in a country?

# Let's discuss:
# (1) What's the relationship between population and democracy?
# (2) What's the relationship beween population size and political repression?

# Model
model.1 = lm(pop ~ democracy + repression, dat)

options(scipen = 1000000) 
summary(model.1)

# Let's interpret the model.

# Checklist: always run this checklist. 

# (1) Interpret coefficients.
summary(model.1)

# (2) Check your std. errors.
summary(model.1)

# (3) Check normality of residuals against your predicted values
plot(model.1$fitted.values, model.1$residuals)

# (4) Check statistical significance (today's topic).
summary(model.1)

#################################################################
# Statistical Significance: p-values
#################################################################

# Statistical significance in simple, is the probability that the estimated betas
# are 0. In this case, there is a 69,84% probability that the TRUE effect of beta(1) 
# isn't really 2345 but 0. Similarly, there is a 24.41% probability that beta(2) 
# isn't 18707 but 0.

# Discuss:
# What's really the threshold we should adopt to distrust/trust our results?

# Those stars denote "statistical significance"
# * = the probability that beta = 0 is equal or less than 1%.
# ** = the probability that beta = 0 is equal or less than 0.1%.
# *** = the probability that beta = 0 is equal to 0%.

# Others:
# "." = the probability that beta = 0 is equal to 5%.

# What can we say about the statistical significance of our model?

#################################################################
# Let's bring in the confidence intervals again.
#################################################################

# P-values and confidene intervals are highly related to eachother. 

# Let's plot the model in three ways.

# 1. Coefficient
# install.packages("coefplot")
library(coefplot)
coefplot(model.1, strict = T)

# 2. Confidence intervals table (just the mean!).
confint(model.1, strict = T)

# Confidence interval of the entire range of the distribution of your x's
library(effects)
plot(allEffects(model.1))

# Other example of the latter.
options(scipen = 999999) # apagar notacion cientifica.
library(ggeffects)
mydf <- ggpredict(model.1)


# Discuss...

# Note the following:
# Whatever is inside the confidence intervals contain the true value.
# P-values---very conveniently---go from 0 to 1.
# P-values larger than 0.005 mean that there is a 5% that beta=0. 
## Think about this again: We don't work with "truths", but with things that are not false! 
## Put it differently, we work with things that are 5% fals, tops. 

#################################################################
# OK, misterio resuelto. Y es por esto que necesitamos pensar en P-values
#################################################################

# En nuestra tabla de regresion, el "p-value" esta dado por la probabildiad de que
# el "valor t" ("t value") sea mayor al numero absoluto de t (en la tabla,
# esta denotado por "Pr(>|t|)").

# Volvamos a mirar la tabla
summary(model.1)

# Vamos por parte.
# Primero, veamos lo que el p-value es (los numeros en la columna  "Pr(>|t|)").

# (1) Un p-value es la probabilidad de que nuestro efecto sea "falso".
# Esto en matematicas significa que nuestro efecto sea realmente "0".

# (2) Como es una probabilidad, el p-value (o valor "p") es una escala
# que va de 0 a 1. 

# (3) En ciencias sociales, existe la convencion de que un p-value 
# superior al 5%, se cuenta como "falso." Es decir, cuando nuestro p-value,
# que es nuestra probabilidad de que nuestro efecto sea falso/cero, es mayor a 5%,
# concluimos que el efecto es "realmente" cero. Ahora, si el p-value es menor 
# a 5%, consideramos que la probabilidad de que sea falso es chica, y podemos
# creer que nuestro efecto en realidad es "verdadero" o mas bien "no-cero" o "no falso".


# Recuerda: 5% significa 5/100=0.05. Entonces, un p-value menor a 0.05 indica que 
# nuestro efecto es verdadero o "no-falso", y un p-value mayor a 0.05 indica que nuestro efecto es falso/0. Es por esto que los p-values de los coeficientes que son iguales o menores a 0.05 tienen estrellas, y los que son mayores no tienen. 


#################################################################
# Estadistico T
#################################################################

# Lo siguiente es el "t value" o "valor t" (o "estadistico t").
# El t value es el coeficiente/error estandard.

48303/19052
2345/6036
18707/15973

# Esto significa que cuando el error estandard es grande (lo que es "malo"), 
# t value se vuelve mas chico. Nosotros queremos lo contrario. Ojala t values
# que son cercanos a dos. En general, esos t values tienen un p-value < 0.05.

# En otras palabras, el t value es una medida de dispersion de nuestra estimacion.
# Mientras mas dispersa, mas alta es la probabilidad de que--en su dispersion--
# nuestra estimacion toque el cero. 

#################################################################
# Al pensar en los p-values y los intervalos de confianza,
# hemos tratado de minimizar nuestros Errores Tipo 1 y 2.
#################################################################

# La logica en investigacion en ciencias sociales tiene que ver con la idea de 
# ver si hay suficiente evidencia en contra de la "hipotesis nula" (es decir, no hay efecto). En otras palabras, un@ no trata de buscar "verdades" (o estimaciones estadisticamente
# significativas). Un@ trabaja con estimaciones que son hasta 5% falsas (o 95% verdaderas).

# En concreto, un@ trata de minimizar la posibildiad del error "Tipo 1".

# Error Tipo 2: falsos negativos.
# Error Tipo 1: falsos positivos.

# Definir ambos.


#################################################################
# Pensamiento Critico
#################################################################

# P-values.
#----

## (1) Criticas al p-value. Por que 5% y no 3% por ejemplo?
## (2) Comunicando resultados: tablas con CI en vez de estrellas.


# install.packages("texreg")
library(texreg)
screenreg(model.1, ci.force = F)


### Tabla que incorpora estas criticas
# install.packages("texreg")
library(texreg)
screenreg(model.1, ci.force = T) # nuestro paquete "screenreg" que ya conocemos,
# pero ahora, forzando los intervalos de confianza ("confidence intervals"), por 
# eso, "ci.force = T" ("T" por "true").



# Asintotica 
#----

## Asintotica, recordemos, es la idea frecuentista de tener 
## una base de datos infinita. Como esto es imposible,
## "el mal menor" es tener la mayor cantidad de datos: mientras mas, mejor.

### Demostrar en la pizarra que esto puede llegar a conducir a otros problemas.
### Mas datos, varianza es mas chica, el valor esperado mas preciso.


#### (1) Mientras mas datos tenemos, nuestras distribuciones se ponen mas perfectas, 
#### delgadas, y precisas. Eso hace que encontremos independencia estadistica mas facil.
#### (2) Falsos positivos! 

hist(rnorm(10,0,1))
hist(rnorm(50,0,1))
hist(rnorm(250,0,1))
hist(rnorm(2500000,0,1))



