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
# Thus, every "i" has its own prestige and schooling levels (as well as the "e"rror level...we'll talk about that later...).

# So, this means we've got the following...

## Name    Schooling (x)    Prestige (y)   beta0      Beta1     Error
# -----------------------------------------------------------------------
## A        10                15            1         2         -6
## B        5                 10            1         2         ?
## C        2                 8             1         2         ?

# Remember (1): it's the same beta (0 and 1) for everyone.
# Remember (2): For person A, the formula 
# "Prestige = b0 + b1Schooling + e", 
# o "Prestige_{i} = b0 + b1Schooling_{i} + e_{i}", which is the same, 
# would be like this for person A:

# Person A: 
# 15 = 1 + 2*10 - 6

######################################################################
# How would it be for Person B and Person C?
# Answer.
######################################################################


## Person B?


## Person C?


######################################################################
## OK; let's continue. Now let's load a real dataset.

if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(car) # En este paquete, "vive" la base "Prestige" ("Prestigio").

# load the dataset
data(Prestige)

# check the dataset 
head(Prestige)

# Note that all betas are calculated as a lineal combination of the X's and the Y.
# Now, let's extract 'x' to get beta1 
x = Prestige$education

# Let's see how "x" looks like
x

# Remember that to get beta0 you need to add a vector with as many 1's as the length of the dataset. 
# Just like we did with our Person A, B, and C dataset.
# That's why many statisticians call it "the constant" (because it's just a constant, not a *variable*).

# Let's tell R to repeat as many 1's as the length of our dataset.
ones = rep(1,length(x)) 

# Let's check
ones

# Now let's combine the "x" and "ones" objects

x = matrix(
  c(unos,x), # plug in 'ones' and 'x'
  ncol = 2 # organize these two guys in 2 columns.
  )

x # Let's inspect the X matrix
            
# Now let's extract the Y vector
y = matrix(Prestige$prestige)

# And inspect it...
y

######################################################################
# Let's calculate beta0 and beta1
######################################################################

# Just to remind you about the operators...

# To transpose, use:
# t()

# To inver, use:
# inv()

# Also, load the matlib library to use the  "inv()" function.
if (!require("pacman")) install.packages("pacman"); library(pacman)
p_load(matlib)

# And to multiply matrices with "matlib", use the "%" operators, like so...
# x*x needs to be entered as  x%*%x

# OK; not it's your turn. 
# Calculate b = (x'x)^-1x'y

######################################################################
# Issues
######################################################################

# This works...
inv(t(x) %*% x) %*% t(x) %*% y

# This doesn't...
inv(x) 

# Why?

inv(t(x) %*% x) # This works...
# This is because, matrices need to be conformable.
# This means that the inner dimensions of the X matrix (2x102, columns/rows) and the
# dimensions of the X' (transposed!) vector is (102x2, columns/rows) DO coincide
# according to the "inner rule". 


######################################################################
# Let's check your work...
# Estimate a lineal regression model but using "lm" 
# You have to use "lm" with the following arguments:
# lm(y ~ x), where Y = Prestige$prestige and X = Prestige$education

model = lm(prestige ~ education, data = Prestige)

options(scipen=9999) # turns off scientific notation
summary(model) # summarizes the output of the model

# Let's do also a little plot.
p_load(sjPlot)
plot_model(model, type = "pred", terms = "education")

######################################################################
# VERY NICE! Bravo! But...what does it mean!?
######################################################################

# Use your own words to describe the results...
# Make sure look at the summary() and the plot.
# What do beta0 ("Intercept") and beta1 (education) mean?
# Answer...



