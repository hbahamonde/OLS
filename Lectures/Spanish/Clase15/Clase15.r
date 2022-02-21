# Propiedades numéricas del OLS, Gauss-Markov, sesgo de variable omitida
#################################################################
cat("\014")
rm(list=ls())
graphics.off()

#################################################################
# Motivacion
#################################################################

# Ademas de trabajar con incertidumbre (intervalos de confianza, p-values, etc.), 
# la estadistica inferencial (lo que estamos haciendo este semestre) 
# descansa sobre supuestos muy importantes.

# Es importante conocer estos supuestos. Te daras cuenta que 
# la principal herramienta cuantitativa de las ciencias sociales 
# tiene muchos defectos y/o supuestos irreales. En consecuencia, siempre
# actua con prudencia y humildad respecto a tus resultados.


#################################################################
# Supuestos de los modelos lineales
#################################################################

# (1) El error tiene promedio cero: por eso SIEMPRE calcula los errores y plotealos.
# (2) El error tiene varianza constante: idem.
# (3) El error no esta correlacionado (los errores son independientes entre si): idem.
# (4) El error esta normalmente distribiuido: idem.
# (5) Las X's estan medidas sin error, y son independientes del error.
# (6) Las X's no son invariables, es decir, las X's son variables, no constantes.

# (*) Punto sobre la diferencia entre ERROR y RESIDUO:
## recuerda que y = b0 + b1x1 + e. 
## Ese "e" en realidad, es un residuo, no "error". "Parametro de poblacion."

#################################################################
# Teorema de Gauss-Markov
#################################################################

# el fundamento matematico de OLS (modelos lineales), es el 
# Teorema de Gauss-Markov.

# Consiste en lo siguiente: si
## (a) el error tiene promedio cero, y
## (b) si el error esta normalmente distribuido, y
## (c) si el error tiene varianza constante,
# entonces nuestros betas son los estimadores mas eficientes y sin sesgo.

# En ingles, es conocido como "BLUE": "best linear unbiased estimator".

# En otras palabras, cuando todos los supuestos funcionan, 
# la diferencia entre la MATRIZ QUE CONTIENE TODOS LOS BETAS CORRECTOS,
# Y LA MATRIZ QUE NOSOTROS TENEMOS ACCESO (O POODEMOS OCUPAR) ES CERO.

# (1) Punto del modelo "real" ("true model").
# (2) Punto del epsilon (error) y la letra "e" (residuo).
# (3) Punto del beta y la letra "b".

# Son diferencias filosoficas. Importantes...pero filosoficas.


# Que puede salir mal?
## Ej.: los errores no son independientes; es decir, son dependientes. 
### Caso de las series de tiempo.


#################################################################
# Sesgo de Variable Omitida: "omitted variable bias"
#################################################################

# Todos los supuestos de OLS operan bajo otro supuesto: el modelo que 
# estimamos, es el "verdadero modelo". Es decir, no se nos queda ninguna
# variable afuera: i.e., todas las variables que debieramos ocupar, estan 
# consideradas. Si esto falla, todo falla, y tenemos "el sesgo de la variable
# omitida".

# Mal que mal, OLS es una ecuacion, y el valor de los betas cambiara si es que 
# no incluimos todas las variables que debieramos incluir. 

## ILUSTRAR EN LA PIZARRA.

# Para demostrar este punto, simularemos (inventaremos) unos datos. 


# Inventemos las variables independientes
set.seed(2020)
x1 = rnorm(1000, mean=0, sd=1) # como nunca, conocemos que el promedio REAL de esta variable es 0
x2 = rnorm(1000, mean=2, sd=2) # como nunca, conocemos que el promedio REAL de esta variable es 2
x3 = rnorm(1000, mean=1, sd=3) # como nunca, conocemos que el promedio REAL de esta variable es 1
x4 = x1*x2


# Definamos que, como debiera ser, el error tiene promedio cero.
e = rnorm(1000, 0)

# Establecer el valor real de los betas: conocemos con exactitud los valores,
# porque nosotros los creamos!
b1 = 1
b2 = -1
b3 = 5
b4 = -2

# El "VERDADERO MODELO": "y" es una combinacion lineal de todas las variables.
y = b1*x1 + b2*x2 + b3*x3 + b4*x4 + e # true model

hist(y)

# Hagamos una regresion.
modelo.completo = lm(y ~ x1 + x2 + x3 + x4)
summary(modelo.completo) # sin sorpresa, los betas son los mismos que inventamos nosotros.

# (1) La tabla de "Residuals" dice que la mediana es 0. Eso es genial. Pero sin sorpresas, nosotros inventamos todo, asi que obvio que resulta bien.
# (2) Plotiemos los errores

plot(modelo.completo$fitted.values, modelo.completo$residuals) 


# Perfecto! No notamos ningun patron.
# Es decir, vemos una nube desordenada de puntos. 
# Aqui es cuando VEMOS lo que asumimos: los errores se cancelan entre si.



# Variable Omitida: Que pasa con nuestros coeficientes cuando se nos quedan dos
# variables afuera?

modelo.segado = lm(y ~ x1)

summary(modelo.segado) # Ya los resultados son muy diferentes.

# (1) Mediana de los residuos? 
# (2) Plotiemos los errores?

plot(modelo.segado$fitted.values, modelo.segado$residuals) 


# Promediemos el error
options(scipen = 1000000) # apagar notacion cientifica.
mean(modelo.segado$residuals)

# Que vemos aqui?
# Que implica?

#################################################################
# Atencion
#################################################################

# Lo peor de todo, es que nunca sabras si te faltan variables o no.
# Es por esto que lo que guia el proceso de anadir/remover variables, es 
# teoria. Es un proceso casi artistico.
