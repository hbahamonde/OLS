# PS 1

# Nombre:
# Fecha:
# Prof. Héctor Bahamonde.
# Ayudante: Gonzalo Barría.
# Fecha entrega: 27 de Oct. 5 pm en uCampus (Tareas).



#################################################################
# 1.
#################################################################
# Crea una base de datos con todos los cursos que tomaste el 
# semestre pasado. La base debe incluir las siguientes variables: 
# (a) curso ("curso"), (b) nota ("nota"), (c) nombre del profesor ("nomprof"), 
# genero del profesor ("genprof"), universidad donde tomaste el curso ("u"). 
# Los nombres de las columnas están en paréntesis. 





#################################################################
# 2.
#################################################################
# Describe la base de datos. Ocupa la función que más estimes 
# conveniente.



#################################################################
# 3. 
#################################################################
# Las variables "varían". Bota la columna que no es variable. 




#################################################################
# 4. 
#################################################################
# Cambiando etiquetas y modificando nombres de variables.

# instala la libreria. 
install.packages("dslabs")
# carga la libreria
library("dslabs")

# Carga la base de datos
data(admissions)

# 4.1. Que tipo de variable es "gender"? Usa un comando para contestar esta pregunta. 

# 4.2. Cambia el nombre de la variable "gender" a "genero".

# 4.3. Cambia el tipo de variable "genero" a factor/variable cualitativa. Pista: necesito que ocupes "levels".


#################################################################
# 5.
#################################################################
#  Transformarciones y creacion de nuevas variables

# 5.1. Usando la misma base de datos "admissions" crea una nueva variable que represente el % de personas que son aceptadas en cada "major". Un "major" es una carrera (en EEUU). Tu "major" seria, por ej., "public administration". Sólo que aquí estan puestos como "A", "B", "C", etc. Atencion: esta nueva variable debe ser parte de la base de datos.


# 5.2 En base a lo anterior, que puedes concluir?

