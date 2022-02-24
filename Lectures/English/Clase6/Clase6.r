# Descriptive Stats: Probability Theory, Distributions, Variance.
#################################################################

# Let's clean everything...
cat("\014")
rm(list=ls())
graphics.off()

# Now, let's install some packages
install.packages("cem")
library(cem)

# But wait, there is a trick to conditionally install packages.
# The idea is to install packages you don't have.
# Since it's virtually impossible to keep truck of what you've installed,
# I really recommend this function.

# Mac users: make sure you have installed XQuartz
# https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.11.dmg

# pacman
if (!require("pacman")) install.packages("pacman"); library(pacman) 
p_load(cem) # if you have "cem", just call it. If you don't have installed it, installe it and call it.

# Let's load the Lalonde dataset.
data(LL)

# Let's see how the data look like.
head(LL)

## Variables

# treated: Indicator variable for whether the participant received the treatment. 
# age: Measured in years. 
# education: Years of education. 
# black: Indicator variable for whether the participant is African-American. 
# married: Indicator variable for whether the participant is married. 
# nodegree: Indicator variable for not possessing a high school diploma
# re74: Real earnings in 1974. re75: 
# Real earnings in 1975. 
# re78: Real earnings in 1978. 
# hispanic: Indicator variable for whether the participant is Hispanic. 
# u74: Indicator variable for unemployed in 1974. 
# u75: Indicator variable for unemployed in 1975.


#################################################################
# Descriptive Statistics
#################################################################



#################################################################
# Mean (or "average").
#################################################################

# 1) It's the most used "moment" used to study the centrality of the distribution. 
# 2) All "data generating processes" have their own distributions...let's see the distribution of "age"

# Let's see one plotting a histogram.
histogram(LL$age)
# The mean should be around 20 years-old.

# Now, let's not just eye-ball it, but use a function to actually get the mean.
mean(LL$age)

# Let's round the mean now...
round(mean(LL$age), 1) # 1 decimal.
round(mean(LL$age), 0) # 0 decimal.

#################################################################
# Median.
#################################################################

# It's the value in the middle of an ordered distribution.
# Advantage: it's more robust to extreme values (these distort the kind of information we would get from the mean).
# The median, actually, is not affected by extreme values (values that you should consider when computing the mean).
# In a normal distribution, mean = median = mode.

# Let's first order the distribution of age.
LL$age
ll.age.ordered = sort(LL$age)
ll.age.ordered

# Let's compute the median.
median(LL$age)

# OK. These values are ordered. 
# Now, let's take this vector, and find out its lenght.
length(ll.age.ordered) 

# It's important to find out it's length because we want to find what's in the middle (i.e. that's the median).
length(ll.age.ordered)/2 

# Now, let's see the element that "lives" in the middle (361). 

# 361 is an uneven number. What do we do we this?

# Let's now call the 361th element... 
ll.age.ordered[361]

# Lets check if our computation is correct.
median(LL$age) == ll.age.ordered[361]

# Is this a normal distribution?
round(mean(LL$age), 0) > median(LL$age)

# What does that mean?
# We have positive "skewness." There are extreme values that are pulling the distribution to upwards. 

#################################################################
# Let's get a more complete summary
#################################################################

# whole dataset
summary(LL) 

# just the variable
summary(LL$age)

#################################################################
# Frequency Tables
#################################################################

# How many married individuals?
table(LL$married)

# How many married African-Americans?
table(LL$married, LL$black) 
# It's always table(ROW, COLUMN).

#################################################################
# Dispersion Measures
#################################################################

# Besides studying "central tendency measures", we can also study how disperse are data are.
# Or in other words, how far away from the mean the observations are. 
# And for that, we use the "variance."
var(LL$age)

# What does it mean? Is it too bad? How can we know?
# How can we fix it?

# Solution: standard deviation.
sd(LL$age)

# Let round it a bit..
round(sd(LL$age),0)

# The s.d. is the square root of the variance. That is, is a scaled (and hence, comparable) measure for dispersion. 
# Now, we can compare std. deviations between, for ex., two distributions.

# Let's check what I said it's true
sqrt(var(LL$age)) == sd(LL$age)

# "Ok---prety interesting, but what do we do with this, exactly?
# There is the "68-95-99.7" rule *which applies only for normal distributions* (our variable is NOT normal in anycase).

# 68% of the data will land around +/- 1 std. deviation from the mean. That is: 
mean(LL$age) - round(sd(LL$age),0) # minimum range.
mean(LL$age) + round(sd(LL$age),0) # maximum range.

# 95% of the data will land around +/- 2 std. deviations from the mean.
mean(LL$age) - 2*(round(sd(LL$age),0)) # minimum range.
mean(LL$age) + 2*(round(sd(LL$age),0)) # maximum range.

# 99.7% of the data will land around +/- 3 std. deviations from the mean.
mean(LL$age) - 3*(round(sd(LL$age),0)) # minimum range.
mean(LL$age) + 3*(round(sd(LL$age),0)) # maximum range.

