# Problemas y post-estimation: multicolinealidad perfecta, 
# heteroskedasticidad, no linearidad, outliers, no normalidad de residuos, auto-correlación

#################################################################
cat("\014")
rm(list=ls())
graphics.off()

#################################################################
# Motivacion
#################################################################
# (1) Los modelos lineales deben ser...lineales. Es decir, 
# OLS asume que la relacion entre "x" e "y" puede ser representada
# por una linea recta. Podemos "desafiar" este concepto de "linea recta"?

# (2) Los modelos lineales asumen "varianza constante entre los errores". 
# Como podemos checkear ese supuesto? Como lo podemos arreglar? Como lo podemos
# derivar matematicamente? Que relacion tiene con los outliers?
# Var Constante: Homoesquedasticidad.
# Var no-const: Heteroskedasticity.

# (3) Como podemos detectar outliers? Como podemos solucionar este problema? 

# (4) Por que el aporte de una variable independiente en la dependiente
# podria NO SER lineal, es decir, curvilinea? Este punto es importante. Que cosas
# en la sociedad NO SON LINEALES?
#################################################################
# Linearidad y no Linearidad
#################################################################
library(car)
data(Prestige) 

options(scipen = 100000)

modelo.lineal <- lm(prestige ~ income + education + women, data=Prestige) 
summary(modelo.lineal)


# Plotear errores: manera "artesanal"
plot(Prestige$prestige, modelo.lineal$residuals)

# Con paquete:
crPlot(modelo.lineal, "income") # Problema.
crPlot(modelo.lineal, "education") # no es exactamente lineal, pero es tolerable.
crPlot(modelo.lineal, "women") # no hay relacion, pero no hay problemas con los residuos.


# (1) El "aporte" de cada variable independiente debe ser lineal, es decir, una 
# linea recta. Esto es la parte del "componente".

# (2) El error de cada parte del "componente", debe ser lineal y normalmente
# distribuido. Esta es la parte del "residuo".

# Veamos. El "componente" es azul, y el "residuo" morado.


# Estimemos una regresion no lineal
modelo.no.lineal = lm(prestige ~ poly(income, 3) + poly(education, 2) + women, data = Prestige)
summary(modelo.no.lineal)

# crPlot con el polynomial
crPlot(modelo.no.lineal, "poly(income, 3)") 
hist(modelo.no.lineal$residuals)
mean(modelo.no.lineal$residuals)
# Ahora ya no hay problema con esta variable. Ademas, hemos mejorado nuestro error total.


# Comparemos los errores
## (1) Que modelo tendra menos errores y por que?

# resumamos los residuos
summary(summary(modelo.lineal)$residuals)
summary(summary(modelo.no.lineal)$residuals)
# Una distribucion normal (como se supone que debieran ser los errores): media = mediana = moda = 0. Y ESTE NO ES EL CASO. (MEDIA ES DIFERENTE DE MEDIANA).


# grafiquemos los residuos
library(lattice)
xyplot(modelo.lineal$residuals ~ modelo.lineal$fitted.values, type=c("smooth", "p")) # mal.
xyplot(modelo.no.lineal$residuals ~ Prestige$prestige, type=c("smooth", "p")) # algo mejor.

# Grafiquemos el "aporte" NO LINEAL de las variables independientes
library(effects)
plot(effect("poly(income, 3)", modelo.no.lineal)) # es el menos lineal de todos
plot(effect("poly(education, 2)", modelo.no.lineal)) # es el mas lineal.


# El punto es que nuestros modelos estan disenados para ser LINEALES.
# La manera en que podemos solucionar este tipo de problemas, es recurriendo
# a transformaciones. 

# Nuestro problema es el siguiente: debemos estimar un modelo lineal, pero 
# la relacion entre X e Y no es lineal. Entonces, como podemos estimar modelos 
# lineales cuando tenemos relaciones no lineales?


#################################################################
# Linearidad y no Linearidad: Resolviendo el problema via transformaciones
#################################################################

# (1) Box-Tidwell Test
## Estimar usando este test a cuanto tenemos que elevar nuestras variables 
## problematicas, en este caso ingresos (income).

boxTidwell(prestige ~ income, ~ education + women, data=Prestige)
# OK. Sugiere que debemos elevar income al "0.08073"

# estimemos un modelo nuevo, pero con "income" transformado
Prestige$income.transformado = Prestige$income^0.08073 # transformemos income

# veamos como se ve income "normal" y "transformado"
xyplot(Prestige$prestige ~ Prestige$income, type=c("smooth", "p")) # el "normal" esta mal porque no es lineal.
xyplot(Prestige$prestige ~ Prestige$income.transformado, type=c("smooth", "p")) # el transformado arregla el problema porque ahora si que tenemos una relacion lineal entre Y y X.


# OK. Ahora estimemos un nuevo modelo ocupando nuestro "income" transformado, y
# veamos si soluciona el problema de fondo (no tener varianza constante en los errores).
# Al final del dia, ese es el problema de no tener linearidad entre uno de los Xs y nuestra Y.

# modelo con "ingresos" (income) transformado
modelo.no.lineal.box.tid = lm(prestige ~ income.transformado + education + women, data=Prestige) 

# Hagamos un scatter entre los residuos y cada una de las x (transformada y normal)
xyplot(modelo.no.lineal.box.tid$residuals ~ Prestige$income.transformado, type=c("smooth", "p")) # bien.
xyplot(modelo.lineal$residuals ~ Prestige$income, type=c("smooth", "p")) # mal.

# Resumen de los residuos: modelo con "income" transformado y normal.
summary(summary(modelo.no.lineal.box.tid)$residuals) # Mucho mejor residuos.
summary(summary(modelo.lineal)$residuals) # No bien.

# graficar la densidad (integral) de los residuos
library(lattice)
densityplot((modelo.no.lineal.box.tid)$residuals) # bien
densityplot((modelo.lineal)$residuals) # mas o menos no mas...

# (2) Tomar el log de la variable no lineal (en este caso, "ingresos" o "income")
Prestige$log.income = log(Prestige$income)

## veamos como se ve cada variable
library(lattice)
densityplot(Prestige$income)
densityplot(Prestige$log.income)

# modelo
modelo.log.income = lm(prestige ~ log.income + education + women, data=Prestige) 

# resumen del modelo
summary(modelo.log.income)
# (1) Como interpretamos este tipo de modelos (con una X logeada)?

# Hagamos un scatter entre los residuos y cada una de las x (transformada y normal)
xyplot(modelo.log.income$residuals ~ Prestige$income.transformado, type=c("smooth", "p")) # bien.
xyplot(modelo.lineal$residuals ~ Prestige$income, type=c("smooth", "p")) # muy mal.

# Resumen de los residuos: modelo con "income" transformado y normal.
summary(summary(modelo.no.lineal.box.tid)$residuals)
summary(summary(modelo.lineal)$residuals)

#################################################################
# Outliers
#################################################################

# Parte del motivo de que algunas veces tenemos varianza no constante en los 
# residuos, es por la presencia de outliers ("observaciones inusuales").

# Que podemos hacer respecto a esto? 
## (1) Borrar los outliers?
## (2) Como detectamos los outliers? 


# Existen dos tipos de outliers: leverage e influence.

#################################################################
# Influence: observaciones que tiran la linea de regresion hacia arriba/abajo
#################################################################

# Demostrar ejemplo en la pizarra.

library(foreign) # significa "foraneo"
load(url("https://github.com/hbahamonde/OLS/raw/master/Datasets/data.rdata"))
dat = data_reg

# veamos como se ven los datos
head(dat)

# estimemos modelo 3 de la tarea # 5
m3 = lm(y3 ~ x3, dat)

# veamos como se ven los problemas de "influence"
library(lattice)
xyplot(m3$residuals ~ dat$x3, type=c("smooth", "p")) # residuos no tienen varianza constante.
# Pero en especial, hay un punto con mucha "influencia"

# Una ruta es la inspeccion visual. Tratemos de hacer algo mas sistematico. 
# Calculemos el "Cook's Distance" que es una medida de cuantificar cuanta "influencia"
# tiene cada punto. 

options(scipen=100000000) # increases threshold for scientific notation (it's got very small numbers).

dat$cooks.d <- cooks.distance(m3) 

# veamos que es el Cook's D.
dat # Por cada dato (o punto), tenemos un Cook's D. Fijate que la observacion numero 3 tiene mucho Cook's D. 
# ESE ES NUESTRO OUTLIER.

# grafiquemos los Cooks'D
# install.packages("olsrr")
library(olsrr)
ols_plot_cooksd_chart(m3)

# Ver el error
dat$residuals = as.vector(m3$residuals)

# El punto de quiebre es 4/n. 
4/nrow(dat) # Lo que esta arriba de 0.3636364 (arriba de la linea roja, es influence).

#################################################################
# Leverage: observaciones que tiran la linea de regresion hacia el lado izq/der
#################################################################

# Demostrar ejemplo en la pizarra.

# Estimemos un modelo con leverage
autos <- lm(mpg ~ wt, data = mtcars)
summary(autos)

# ahora, grafiquemos lo que vemos vs. lo que predecimos
plot(autos$fitted, mtcars$mpg) # Donde esta el problema? 

# Dado que SI tenemos un problema, nuestro error debiera seguir algun patron.
# Es decir, debieramos NO ver una nube dispersa, y la linea debiera ser curva. Veamos.
xyplot(autos$residuals ~ mtcars$wt, type=c("smooth", "p")) # residuos no tienen varianza constante.

# Ocupemos una funcion de R para detectar observaciones con leverage.
ols_plot_resid_stud_fit(autos) # OK. Son las mismas 3 observaciones que habiamos visto (17, 18 y 20)


# armemos una base de datos, solo para ver que observaciones/marcas son...
data.frame(
        res = autos$residuals,
        marca = rownames(mtcars),
        fila = 1:nrow(mtcars)
        )

#################################################################
# Errores Estandard Inflados: Multicolinearidad ("imperfecta") y Multicolinearidad Perfecta
#################################################################

# Inventemos las variables independientes
set.seed(2020)
x1 = rnorm(1000, 10)
x2 = rnorm(1000, 20) 
x3 = (x2*x2)/1000 # x3 es una combinacion linear de x2

# Definamos que, como debiera ser, el error tiene promedio cero.
e = rnorm(1000, 0)

# Establecer el valor real de los betas: conocemos con exactitud los valores,
# porque nosotros los creamos!
b1 = 1
b2 = -100
b3 = 500

# modelo verdadero ("true model").
y = b1*x1 + b2*x2 + b3*x3 + e

# Modelo completo
modelo.completo = lm(y ~ x1 + x2 + x3)
summary(modelo.completo)

# Modelo incompleto
modelo.incompleto = lm(y ~ x1 + x2)
summary(modelo.incompleto)

# Si Variance Inflation Factor (VIF) > 4....multicollinearity
library(car)
vif(modelo.completo) 
vif(modelo.incompleto)

# Ver como se "inflan las varianzas". Y como nosotros creamos estos datos,
# sabemos que no es debido a "error de medicion". Sabemos exactamente cual es el
# problema: x3 es una combinacion lineal de x2.

# Ejemplo real: hay muchas cosas que en la sociedad estan correlacionadas, por ej?

### Ejemplo Extremo

ej.extremo = lm(y ~ x1 + x2 + x2)
summary(ej.extremo)

x2.prima = x2
ej.extremo.2 = lm(y ~ x1 + x2 + x2.prima)
summary(ej.extremo.2)
