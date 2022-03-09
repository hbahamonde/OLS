### R code from vignette source 'Clase_14.Rnw'

###################################################
### code chunk number 1: setup
###################################################
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(knitr)
set.seed(2020)
options(scipen=9999999)
if (!require("pacman")) install.packages("pacman"); library(pacman) 



###################################################
### code chunk number 2: i:c:1
###################################################
p_load(effects)
data(Duncan)
summary(Duncan)


###################################################
### code chunk number 3: i:c:2
###################################################
modelo.1 = lm(prestige ~ income*type, data = Duncan)
summary(modelo.1)


###################################################
### code chunk number 4: i:c:3
###################################################
term.int <- effect("income*type", modelo.1)
plot(term.int, as.table=T)


###################################################
### code chunk number 5: i:c:4
###################################################
p_load(scatterplot3d)
scatterplot3d(Duncan$income, Duncan$type, Duncan$prestige, color = as.numeric(Duncan$type))


###################################################
### code chunk number 6: i:c:5
###################################################
p_load(car,rgl)
data(iris)
sep.l <- iris$Sepal.Length
sep.w <- iris$Sepal.Width
pet.l <- iris$Petal.Length
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species)


###################################################
### code chunk number 7: output
###################################################
knitr::purl('Clase_14.Rnw')
Stangle('Clase_14.Rnw')


