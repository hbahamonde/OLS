# Data Visualization (I): bar plots (cat/cont and cat/cat variables), scatter plots, histograms and time-series plots.

cat("\014")
rm(list=ls())
graphics.off()


## Prestige
install.packages("car")
library(car)

############################################
# Histogram: two categorical variables.
############################################

# Let's create a variable that tells us if income is "high" or "low"
Prestige$income.categorical <- ifelse(Prestige$income > mean(Prestige$income), "high.income","low.income")

# Now let's plot categorical (or qualitative) variables. 
# These are usually "factor" variables in R (like "pear", "apple", and "banana"). 
# Now let's convert that variable to "factor"...and then plot.
Prestige$income.categorical = as.factor(Prestige$income.categorical )
plot(Prestige$income.categorical)

# What can we learn about this plot?

# Now let's think about the gender and income relationship...

# First, let's create a variable that classifies whether certain occupations have "high" or "low" female participation.
Prestige$women.categorical <- ifelse(Prestige$women > mean(Prestige$women), "high.women","low.women")

# What type of variable have we just created? Let's ask R...
is(Prestige$women.categorical) # "Character", and that won't plot. 

# Let's transform it to "factor."
Prestige$women.categorical = as.factor(Prestige$women.categorical)

# Let's plot it...
plot(Prestige$income.categorical, Prestige$women.categorical) 

# What can we learn about this distribution?

############################################
# Boxplot: one cat., another continuous
############################################

# This is a boxplot:
plot(Prestige$income.categorical, Prestige$women)

# It shows the first quartile (25%), the median or second quartile (50%), and the third quartile (74%).
# In addition, it shows the minimum and the maximum, plus the outliers...a lot of information!

# What does this particular plot show?

############################################
# Scatterplot: two continuous ("numeric") variables.
############################################

# What's the relationship between prestige and income? Let's see...

plot(Prestige$prestige, Prestige$income) 

# What can be concluded from the plot?

############################################
# Density Plots
############################################

# Remember "integrals" from your math classes? It's like scooping a box of ice cream :)
# If you could scoop the whole box, you'd have a density of 1 (the whole box in your spoon).

# Densities are useful to see how the distribution behaves.

# install.packages("dslabs")
library("dslabs")
data("heights")

# install.packages("ggplot2")
library(ggplot2)

ggplot(heights, aes(height, fill=sex)) + geom_density(alpha = 0.2)

# What can be concluded from this plot?

# Where is the mean in a normally-distributed density?

############################################
# Time series plots // Working with time...
############################################

# Let's see the monthly sales of a gift store in a hotel in Australia

# The date goes from 1987 to 1993. 
souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat") 
# Yes! R allows loading data directly from the Internet.

souvenir

# Ok, this is just a sequence of numbers...let's make this array of information more tractable...
# Let's declare that the object "souvenir" as a time-series object.
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1)) 
# 12 is the interval (12 months per year), which begins the month number 1 of the year 1987.

souvenirtimeseries

# Ok, this makes much more sense.

# Let's summarize this information
summary(souvenirtimeseries) 
# Is this helpful?

# What kind of object is this? 

is(souvenirtimeseries) 
# "ts" means "time series."

# Let's plot it.
plot.ts(souvenirtimeseries) 

# The Y-axis is in scientific notation.
# Let's turn that off increasing the threshold for R to activate it. 
# Let's put an arbitrarely "large" number. 
options(scipen=9999)

# And let's plot it again.
plot.ts(souvenirtimeseries)

# What can be learned from this plot?