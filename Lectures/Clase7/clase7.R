# Estadística descriptiva (II): binomial, normal, otras; simulación.

cat("\014")
rm(list=ls())
graphics.off()
options(scipen=9999999)


############################################
# Tipos de Distribuciones
############################################

# Objetivos: 
        # 1) Existen mas distribuciones que la distribucion normal.
        # 2) Las distribuciones se ven distintas.
        # 3) Cada una de ellas tienen una manera intuitiva de reconocerlas.
        # 4) Los metodos que ocuparemos desde la proxima clase, estaran orientados solo a modelar distribuciones normales.

# Ocuparemos los comandos de "simulacion" empaquetados en R para ver cómo se ve cada distribución.

############################################
# Normal
############################################

set.seed(123)
dist.normal = rnorm(100, mean = 0, sd = 1)

hist(dist.normal)
summary(dist.normal)

# Caracteristicas de la Dist. Normal.
        # 1) - inf a + inf
        # 2) moda = mediana = media ("promedio")
        # 3) Números continuos (no "discretos"). Qué significa?


############################################
# Bernoulli
############################################

        ## Dos resultados: 0's o 1's.
        ## Ejemplos? 
        ## Es continua o discreta?


install.packages("LaplacesDemon")
library(LaplacesDemon)

set.seed(123)
bern=rbern(10, 0.5)
        # 1) numero de observaciones
        # 2) probabilidad de exito del "experimento".
       
        ## EJ., si pongo 10 observaciones, son 10 monedas que lanzamos de una vez. Si pongo 0.5 de probabilidad (ie 50%), cada 
        ## moneda dará cara o sello con un 50% de probabilidad.

## cambiemos la probabilidad de que salga cara (1), a una probabildiad mas alta
set.seed(123)
rbern(10, 0.9)

############################################
# Binomial
############################################

# Es como la Bernoulli, pero para varios experimentos. Imaginate, 24 sets de 10 monedas 
# que lanzamos; un set a la vez. Aqui tenemos "24 experimentos".

set.seed(123)
rbinom(10, 24, 1)
        # 1. numero de observaciones.
        # 2. numero de "experimentos".
        # 3. probabilidad de exito de cada "experimento". 

        ## Ej., si el numero de experimentos es "24", y la probabilidad especificada es 1, los 
        ## 24 experimentos daran 1.

set.seed(123)
rbinom(10, 3, 0.5)
# 1. numero de observaciones.
# 2. numero de "experimentos".
# 3. probabilidad de exito de cada "experimento". 

# Si es "0.5", la posobilidad de que en estos 10 experimentos salga un "3" es de 50%.



###########################################
# Distribucion Multinomial
############################################

        # Extension de la Binomial, pero para mas de un tipo de resultado. 
        # Ejemplos?

set.seed(123)
rmultinom(10, size = 1, prob = c(0,0.2,0.9))

        # numero de experimentos
        # numero de resultados ("si/no").
        # numero de alternativas ("medios de transporte": "bus", "taxi", "bici")



###########################################
# Poisson
############################################

## Cuentas.

set.seed(123)
rpois(100, 10)

set.seed(123)
hist(
        rpois(100, 10)        
)

###########################################
# Distribucion Exponencial
############################################

set.seed(123)
rexp(100)

hist(
        rexp(100)
        )

## Ejemplos?


###########################################
# Distribucion Lognormal

## Muchos valores bajos, pocos valores altos. Ejemplos?

set.seed(123)
rlnorm(100, meanlog = 0, sdlog = 1)

set.seed(123)
plot(
        density(
                rlnorm(100, meanlog = 0, sdlog = 1)
        )
)


###########################################
# CASOS ESPECIALES
###########################################

# Ahora, solo para conocimiento gral., veremos otras distribuciones.
# El punto importante, mas alla de saber (o no) programar esto, es que veas 
# que las distribuciones son realizaciones de cuestiones cotidianas que
# se ven en las ciencias sociales en general.





###########################################
# Distribucion Logistica
###########################################

## Ejemplos?



set.seed(123)
rlogis(100)


cdf=function(x,mu,s){
        k=(x-mu)/s
        return(1/(1+exp(-k)))
}

x=seq(-10,13,0.01)

plot(x,cdf(x,-1,1),type="l")


###########################################
# Chi Cuadrado
###########################################

## Es la distribucion que sigue la suma de los cuadrados minimos.


set.seed(123)
rchisq(10000, 2)

set.seed(123)
plot(
        density(
                rchisq(10000, 2)
                )
        )


