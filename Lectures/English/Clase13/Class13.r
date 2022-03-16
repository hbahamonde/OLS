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
# P-values larger than 0.005 mean that there is more than a 5% chance that beta=0 
# So we consider it as FALSE!
# Think about this again: We don't work with "truths", but with things that are not false! 
# Put it differently, we work with things that are at most 5% false,
# or things that are least 95% "true."


#################################################################
# T Statistic
#################################################################

# The t-statistic is just the coefficient/std. error.

48303/19052
2345/6036
18707/15973

# This means that when our std. error is big (something that we do NOT want)
# the t-statistic becomes smaller. We want the opposite.
# We want t statistics that are close to 2. In general, those t statistics
# have a p-value < 0.05.

# In other words, the t statistic is a measurement of dispersion of our estimation.
# The more disperse, the higher the probability that our estimatation gets closer to 0.




#################################################################
# All we have done is just to quantify the way we social scientist
# test our hypotheses.
# Enter the "Type 1" and "Type 2" errors.
#################################################################

# In social sciences we don't "search for the truth," but rather
# verify if certain hypothesis "survives" a bunch of (statistical) proofs.
# If our hypothesis does survive, we stick to that idea (until it gets 
# "falsified" in the future).

# In other words, we try to rule of Type 1 errors
# Type 1 Errors: false positives.

# There are also Type 2 errors:
# False negatives. 

#################################################################
# Critical Thinking
#################################################################

# P-values.

# (1) Do you feel comfortable with the idea of the 5% threshold? Why not 3? 
# (or something else?)

# (2) Communicating results in tables AND overcoming the 5% "dictatorship" 

# install.packages("texreg")
library(texreg)
screenreg(model.1, ci.force = F) # WITHOUT C.I.

screenreg(model.1, ci.force = T) # WITH C.I.


# Asymptotics 
#----

# Asymptotics is the idea that the more data, the better.
# Within the framework of "frequentist" statistics (our world...)
# one of the assumptions is that our analyses assume
# we HAVE INFINITE DATA! But, Do we?

hist(rnorm(10,0,1))
hist(rnorm(50,0,1))
hist(rnorm(250,0,1))
hist(rnorm(2500000,0,1))

# As we can see, another potential problem with this is that the more data
# we have, the more "perfect" our distributions will be. 
# This has a direct impact on statistical significance: it makes it EASIER
# to find statistical significance. 
# In other words, when we have really huge datasets, EVERYTHING becomes
# statistical significant. 




