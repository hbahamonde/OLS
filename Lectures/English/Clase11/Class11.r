# Error, residual and e.
#################################################################
cat("\014")
rm(list=ls())
graphics.off()

# In this class we will work with a famous data set called 
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

# "Multiple" o "multivariate" regression models have more than one X.

# Let's think for a bit about the meaning of the concept "INDEPENDENT variable."
# What's supposed to be "independent" about an "independent variable"?

# Let's write our basic OLS equation model again.
# y = b0 + b1x1 + b2x2 + b3x3 + e

# Let's dicuss these:
# (1) Why are independent variables called "independent"?
# (2) Does it matter the order in which the X's are arranged in the equation?
# (3) How many X's should I put in the equation?
# (4) Which independent variables CAN'T include?

#####################
# WE CANNOT DO THESE
#####################

# (4.1) We can't put the same variable on both sides of the "="
# That is, we can't do "y ~ y" (or "x ~ x").

# Let's create a toy example 
pj = data.frame(
  brand=c("A", "B"),
  number=c(3,5)
  )

# inspect the object
pj 

# Model
lm(pj$number ~ pj$number) # Error...


# (4.2) The same variable twice.

# That is, y = x1 + x1 # CAN'T DO THAT 
# Let's see why...

# let's create a matrix
x = matrix(
  c(3,5,3,5),
  ncol = 2
  )

# inspect the object
x

# Let's remember how beta is calculated
# (x'x)^-1x'y

# Transpose x
t(x) # OK, this is possible

# Multiply x'x
t(x) %*% x # OK, also possible

# Now, let's keep on going, and try to invert (x'x)
library(matlib)
inv(t(x) %*% x) # Matrix is not invertible.
# Technically, this means that the "determinant" of the matrix is 0.

# Let's try anyways...
summary(lm(repression ~ democracy + democracy, dat)) # What happened here?

# This problem has a name: *perfect* multicollinearity.  

# Let's see another example of multicollinearity.
m2 = matrix(c(3,5,6,10), ncol = 2)

m2 

# Do you notice anything interesting about this matrix?


# let's take the determinant of "m2"
options(scipen=10000) # turns off scientific notation
det(m2) # determinant is 0, hence matrix is not invertible.

# Let's discuss:
# (1) When can we have this kind of problem of perfect collinearity?
# (2) Do you think this problem is common at all?

# OK, let's continue...

# Now let's estimate a multivariate model.

# What can explain levels of repression? 
colnames(dat)

# "pop" (population)?
# "rgdpch" (economic growth)?
# "vdiss" (terrorism)?

multivariate.model = lm(repression ~ democracy + pop + vdiss, dat) # what else?

summary(multivariate.model)

# let's compute the prediction y'
dat$repression.prime2 = predict.lm(multivariate.model)

# Now, let's calculate the error 
dat$error2 = multivariate.model$residuals

# Let's check...
head(dat)

# Let's plot the residual: Density Plot *check for normality*.
p_load(lattice)
densityplot(dat$error2)

# Let's plot the residual: Scatter Plot *check for patterns*.
plot(dat$repression.prime2, dat$error2)

# Check the model. Later we will discuss this plot in more depth.
plot(multivariate.model)

# Summary
summary(dat$error2)

#Let's think about the coefficients (betas).

# Let's discuss:
# (1) How do you interpret the betas now that we have more variables? (remember, it's a multivariate model).
# (2) What does it mean (substantively) "constant at their means"?


########################
# Different Ways to Show Results: Tables and Plots (coefplot)
########################

# Uncertainty.
# We never will know if we have the "true model."
# That's why we always try different specifications.

p_load(texreg) # package to display a regression table but for several models.

screenreg( 
  list( 
    biv.model, # first model
    multivariate.model # second model
  )
)

# How do we interpret this table?

# Let's plot our results. It conveys the same information! 
p_load(coefplot)
multiplot(
  biv.model,
  multivariate.model
  )

# How do we interpret this plot?