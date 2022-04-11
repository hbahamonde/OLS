# Confidence intervals, standard error and variance-covariance matrix.
#################################################################
cat("\014")
rm(list=ls())
graphics.off()


library(foreign)
options(scipen = 1000000)
dat = read.dta("https://github.com/hbahamonde/OLS/raw/master/Datasets/cow.dta")

# Let's estimate a model about the relationship between economic growth and democracy, controlling for population.
model.1 = lm(rgdpch ~ democracy + pop, dat)
summary(model.1)

# What does it mean "controlling for population"? 

# Let's get our confidence intervals. 
confint(model.1, level = 0.95) # 95% of confidence.
confint(model.1, level = 0.99) # 99% of confidence.

# Let's discuss this a little bit further...
# In social sciences we usually use 95% of confidence.
# (1) "Confidence" in *what* exactly?
# (2) Why 95% and not, say, 92%?
# (3) What do these number mean anyways? 
# (4) Why do the "2.5%" and "97.5%" numbers in the table mean? (Use whiteboard...)

# Very powerful idea: our estimates (e.g., betas) are ESTIMATIONS...duhhh.
# This means that the price we pay for them is UNCERTAINTY. 
# Let's SEE this uncertainty.


# install.packages("dotwhisker", "ggplot2")
library(dotwhisker, ggplot2)
dwplot(model.1, show_intercept = T)

# (1) Compare the coefficients in the table and in the plot. 
# (2) What do we see in the plot?
# (3) What can we say about the different coefficients?
# (4) What can we say respect to the *precision* of our estimates? 
# (5) What do we want? And what do we want to avoid? 
# (6) Why are we getting wide/narrow confidence intervals? Does that depend on what exactly?


# Now, bare in mind that the uncertainty that dotwhisker shows is for the mean (average) of that distribution.
# A better view is to observe how our estimated uncertainty VARIES as we move along the range of our variable. 
# Make sure you understand this: it is REALLY important.

# Let's see this in practice. 

# install.packages("effects")
library(effects)
plot(allEffects(model.1))

# (1) What are we seeing here? 
# Let's see the effect on the whiteboard, and draw the lineal delta. (1638 democracy)
# (2) Do you see anything that might explain part of our uncertainty?

# Now that we know that the confidence intervals are, let's figure out where they come from, and how
# can we calculate them.


########################################################
# Manual computation of confidence intervals
########################################################

# Everything begins estimating the variance of the error (how disperse the error is)
# We call this sigma^2

# First, let's extract the estimated error. 
e = as.vector(model.1$residuals)
e 

# Second, let's see how many parameters we estimated. 
k = 3 # number of variables we used in our model (including the intercept) 
# We've got "democracy", "pop", "Intercept". 

# sigma.2 (variance of the error)
# Mathematically, it's just the sum of the diagonal elements  of the (e*e')/N-k matrix 
sigma.2 = (1/(nrow(dat)-k))*sum(diag(e %*% t(e)))

# Third, let's get the X matrix ("what we observe").
# To obtain the intercept, we will put a column of 1's of the same length of our X matrix.
ones = rep(1, nrow(dat)) 


# OK, let's generate the "X" matrix
x = matrix(c(ones, dat$democracy, dat$pop), ncol=3) 
x 

# Let's estimate the standard errors. 
summary(model.1) # Actually our table tells us the standard errors. They are SUPER important (they tell us our uncertainty).

# To compute the standard errors, first we need to take a look at the variance-covariance matrix.
# Variances are the diagonal elements of the matrix, and the covariances are the off-diagonal elements of the matrix.

# install.packages("matlib")
library(matlib)

# Let's calculate the variance-covariance matrix.
# To do this, we should do the following:
# sigma^2 * (x'x)^-1

options(scipen=999)
sigma.2 * inv(t(x) %*% x)

# Luckily there was a shorter way...
vcov(model.1)

# Remember, the variance-covariance matrix has important elements to calculate the std. errors.
# At the same time, the std. errors are important to compute the confidence intervals. So...
# Variance-Covariance Matrix --> Std. Errors --> Confidence Intervals.

# Interestingly, the square root of the diagonal elements of the matrix (e.g. the variances) are the std. errors!
sqrt(diag(sigma.2 * inv(t(x) %*% x)))

# Let's check...
summary(model.1)

# But hey, let's try to really understand what the std. errors are. (Now that we know how to calculate them).
# Std. errors are a measure of uncertainty of our coefficients. The larger the error, the larger the uncertainty. 
# How large or small are your std. errors? Std. errors just make sense in the context of your model/coefficients. And really there isn't a "rule of thumb" to say "this is a "big"/"small" std. error. 
# However, the unit of the standard errors is the same as your x.

# Not let's talk about confidence intervals. 
# Remember, confidence intervals are constructed using the std. errors.

# Let's define our "degrees of freedom" 
degrees.of.freedom = nrow(dat)-2

degrees.of.freedom 

# Let's define the formula of the confidence intervals.
# coefficient +/- t * Std. Error of the Coefficient
# It's a "double" calculus...
# coefficient + t * Std. Error of the Coefficient
# coefficient - t * Std. Error of the Coefficient

# Note that it's all about the coefficient.

# But there is a new element "t".
# That value is a critical value extracted from the "t distribution".

# We will use a function to obtain these "critical values" (from the t distribution).
t = qt(1-.05/2, degrees.of.freedom) # critical values for 95% confidence intervals.
# And we divide this by two because we want to "split" this "confidence" in both sides of the distribution.

# 
10631.611789 - t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[1]  # (Intercept)  #  9136.09240230
10631.611789 + t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[1]  # (Intercept)  #  12127.13117506

#
1638.874546  - t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[2]  # democracy  # 1179.996
1638.874546  + t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[2]  # democracy  # 2097.753

#
0.002947     - t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[3]  # pop 
0.002947     + t * sqrt(diag(sigma.2 * inv(t(x) %*% x)))[3]  # pop 


# But hey, there was a shorter way again...
confint(model.1, level = 0.95) # 95% de confianza

# Discuss
# "Frequentist" paradigm: What does 95% mean? Hint: if this "experiment" were repeated 100 times...