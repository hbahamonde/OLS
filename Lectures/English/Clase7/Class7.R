# Descriptive Stats (II): binomial, normal, others; simulation.

cat("\014")
rm(list=ls())
graphics.off()
options(scipen=9999999)


############################################
# Types of Distributions
############################################

# Objectives: 
        # 1) There are many more distributions than the normal one.
        # 2) Distributions "look different"!
        # 3) Each one of them has a distinctive way of recognizing them.
        # 4) Most of the methods we will learn this semester are suited for studying normal distributions only.

# We will use simulations methods to learn how different these distributions look alike.

############################################
# Normal (Standard)
############################################


set.seed(123) # lets set a pattern for the random-generating process.
dist.normal = rnorm(100, mean = 0, sd = 1)
dist.normal


hist(dist.normal) # plot
summary(dist.normal) # plot

# Properties
        # 1) - inf to + inf
        # 2) Mode = Median = Mean ("average").
        # 3) Continuous numbers (no "discrete").

# Can you know think of an example of this distribution? Think of something "social" or "political" or even "economic".

############################################
# Bernoulli Distribution
############################################

        ## Two outcomes: Yes/No, 1/0.
        ## Examples? "Are you Left/Right"? "Did you Vote" (Yes/No), etc. 


install.packages("LaplacesDemon")
library(LaplacesDemon)

set.seed(123)
bern=rbern(10, 0.5)
        # Arguments:
        # 1) Number of observations.
        # 2) Probability of "success" of each "experiment."

# In this example, I'll have 10 coins which will be tossed once each. The probability of head is 0.5. 
       
bern

# Now let's rise the probability of head.
set.seed(123)
rbern(10, 0.9)

############################################
# Binomial
############################################

# It's lile Bernoulli, but for several "experiments." Let's imagine 24 sets of 10 coins each. 
# What we toss is a set at a time. Here we have 24 sets (or "experiments").

set.seed(123)
rbinom(10, 24, 1)
        # Arguments:
        # 1. Number of observations.
        # 2. Number of "experiments."
        # 3. Probability of "success" of each experiment.

# For instance, if the number of experiment is 24, and the probability is 1, all 24 coins will be head (i.e. 1, summing 24 each time).

# For instance, if the prob is 0.5, and we run 3 experiments,
# the probability of having three "stacked" 1's (i.e. totalizing 3) is 50%.

set.seed(123)
rbinom(10, 3, 0.5)
plot(rbinom(10, 3, 0.5))

# Can you know think of an example of this distribution? Think of something "social" or "political."

###########################################
# Multinomial Distribution
############################################

# It's an extension of the Binomial, but for more than binary outcomes.
# So, if before we had only 1's and 0's, or Yes's and No's, now we might have
# for example, types of fruits you like (apple, orange, pineapple).

# Can you know think of an example of this distribution? Think of something "social" or "political."

set.seed(123)
rmultinom(10, size = 3, prob = c(0.5,0.5, 0.2))

# Arguments:

# Number of experiments.
# Number of alternatives (i.e., pieces of fruit you like or maybe means of transportation).
# Probability of each success: e.g. probability of "eating" that particular piece of fruit, or "using" those particular means of transportation.

# Can you know think of an example of this distribution? Think of something "social" or "political."

###########################################
# Poisson
############################################

# This one is for counts. 
# For example, "How many children do you have?"

set.seed(123)
rpois(100, 10)

# Arguments: to find out, ask R for help using the "help()" function.
# What does the "lambda" parameter do?

# Important assumption about the Poisson distribution:
# (Conditional) mean = (Conditional) variance. 
# If your (conditional) distribution has different (conditional) mean and (conditional) variance,
# you should never think that the "data generating process" is Poisson.

# What is a "data generating process"?

# If you have counts and (conditional) variance is different from (conditional) mean, 
# you should think that the "data generating process" is rather a Negative-binomial.

# Can you know think of an example of the Poisson distribution? Think of something "social" or "political."


###########################################
# Exponential Distribution
############################################

set.seed(123)
rexp(100)

hist(rexp(100))

# Can you know think of an example of this distribution? Think of something "social" or "political."
# Hint: what good gives you more money at the beginning, but as long as you start consuming more, you don't earn as much more?

###########################################
# Lognormal Distribution
############################################

# Lot's of small numbers, but just a few large numbers.

set.seed(123)
rlnorm(100, meanlog = 0, sdlog = 1)

set.seed(123)
plot(density(rlnorm(100, meanlog = 0, sdlog = 1)))

# Can you know think of an example of this distribution? Think of something "economical."
# Hint: it has to do with earnings.