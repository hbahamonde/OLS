# Loading datasets (II): transformations (logs), creating new variables.
# Manipulating datasets: generating matrices and data.frames, merge, append.

############################## 
# Cleaning
##############################
cat("\014")
rm(list=ls())


# Class 3

## Prestige
# install.packages("car") 
library(car) 

# Load data.frame
data(Prestige)

## Lets summarize the dataset
head(Prestige)

############################################
# Dropping variables/columns
############################################

# Why would you need to do this?

# Drop function
# install.packages("dplyr") 
library(dplyr)

# Let's drop some columns, and let's build three distinct data.frames that share two columns.

# Let's check what columns we already have in the Prestige data.frame.
colnames(Prestige)

# DF1 will have all except for "type" and "census"
Prestige.drop.1 = dplyr::select(Prestige, -c("type", "census"))
colnames(Prestige.drop.1)

# DF2 will have everything but "education" y "women"
Prestige.drop.2 = dplyr::select(Prestige,-c(education, women))
colnames(Prestige.drop.2)

# DF3 will be just "education" and "women"
Prestige.drop.3 = dplyr::select(Prestige, c(education, women))
colnames(Prestige.drop.3)

############################################
# Merging: combining two data.frames (adding columns)
############################################

# Why would you need to do this?

# To merge, you need at least one column in common. 
# And that column should have--hopefully--a continuous variable. But why?

# Let's merge Prestige.drop.1 with Prestige.drop.2 using "income" and "prestige".
# They are the columns in common
colnames(Prestige.drop.1)
colnames(Prestige.drop.2)

Prestige.merge <- merge(Prestige.drop.1, Prestige.drop.2, by=c("income", "prestige"))
Prestige.merge

############################################
# Appending: adding rows
############################################

# Why would you need to do this?

# Let's first split the Prestige data in halves.
# To do this, we will do some recoding: occupations with "high" and "low" prestige.

Prestige$prestige.2 = ifelse(Prestige$prestige > mean(Prestige$prestige), "high","low")

# let's create another data.frame with just the "high" prestige occupations
Prestige.high <- Prestige[(Prestige$prestige.2=="high"),]

# now let's create another data.frame with just the "low" prestige occupations.
Prestige.low <- Prestige[(Prestige$prestige.2=="low"),]

# now, let's put the two halves back together...this requires to have the SAME column names
Prestige.nuevo = rbind(Prestige.high, Prestige.low)

############################################
# Transformations
############################################

# par(mar=c(1,1,1,1))
# install.packages("latice")
library(lattice)

lattice::histogram(Prestige$income) 
lattice::histogram(Prestige$income, breaks=100) 

# What can we say about this distribution? 

# Because of this issue, we will have to "transform" this variable.
# Notice that income (and all things related to money!) behave usually this way. Why?
# The kind of transformation (logs) will "normalize" our distribution.
# What we achieve with normalization is to reduce the "dispersion" of the distribution. Why do we need that? 

log(Prestige$income)

# Are we cheating?
# Does this change our variable, and if so, in what way?

# let's create another column with the transformed variable.
Prestige$income.log = log(Prestige$income)

lattice::histogram(Prestige$income, main="Before", breaks=10)
lattice::histogram(Prestige$income.log, main="After", breaks=10)

# It looks pretty good to me, does it look good to you?

# let's transform the "women" variable
log(Prestige$women)

# Anything interesting you've noticed?

# What's the log of 0?

# Let's fix this
Prestige$plus.one = Prestige$women+1

## Let's check...
head(Prestige)

# Why does that fix our problem?

# What's the log of 1?
Prestige$log.plus.one = log(Prestige$plus.one)

head(Prestige) # Let's check...

# before transforming
lattice::histogram(Prestige$women, breaks = 10)

# after transforming
lattice::histogram(Prestige$log.plus.one, breaks = 10)


# What do we win when we do this?
# What do we lose when we do this?