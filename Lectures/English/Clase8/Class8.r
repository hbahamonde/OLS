# Introducing OLS: What is this anyways?

cat("\014")
rm(list=ls())
graphics.off()
options(scipen=9999999)

#######################################################
# What's the relationship between schooling and prestige?
#######################################################

# Let's create a toy dataset.
data = data.frame(
  name = c("Alfred", "Brandon", "Charly"),
  schooling = c(57,50,61), # vector de educacion
  prestige = c(64,53,67)
)

# let's check the data
data

# let's (visually) inspect the relationship between both variables 
plot(data$schooling,data$prestige) 

# What kind of relationship is this? "Positive" or "negative"?

# Let's now "model" this relationship. 
# What's a "model" anyways? (Hint: map).
model = lm(prestige ~ schooling, data = data)

# Let's analyze beta1 in our model.
summary(model)

# Interpretation: We always begin with our X.
# "For every additional unit in X, Y moves up/down in [beta]."
# ALWAYS, all betas, are expressed in units of the dependent variable (Y).
# They are NEVER probabilities! 
# If your dependent variable (y) is "prestige", beta1 is "units of prestige".
# If your dependent variable (y) is "GDP", your betas (all of them!) will represent "GDP".

# OK, now we know how to quantify the relationship between
# Prestige and Schooling. But, is this a "good" model? How can we know that?


# Let's make a prediction. 
predict(model)

# "A prediction is a prediction" :)
# This means we could come up with any number (a new row, or observation, for instance)
# and plug it into our equation. It's a prediction because I am saying something
# about a data point that wasn't there before. 

# In any case, predicting pretty much tells you about the 
# performance of your model. 
# Consider this: if you observed a "57" but your model predicts a "120"
# your model is not performing well (It's 120-75 points off!). 
# I'll teach you ways to think about this soon.

# In more detail,

# What we see :
# Alfred had a y=64, but our model predicts y=62.63
# Brandon had a y=53, but our model predicts y=53.49
# Charly had a y=67, but our model predicts y=67.85

# Discuss: Are those departures big or small?

# These departures are called "error," and it's the difference
# between the Y we observe and the Y we estimate: the better the model,
# the less "errors," which kind of makes sense. 

# Let's use the whiteboard. 
# Take the regression equation, and plug in the numbers.

#######################################################
# OLS models in matrix form
#######################################################

# Let's go back to our equation:
# y = b0 + b1*x1 + e
# If we rearrange the terms respect to "e", we will have that,
# e = y-beta0-beta1*x
# Let's now do the same with R.


data$error <- c(
  data$prestige[1] - as.numeric(model$coefficients[1]) - (data$schooling[1] * as.numeric(model$coefficients[2])),
  data$prestige[2] - as.numeric(model$coefficients[1]) - (data$schooling[2] * as.numeric(model$coefficients[2])),
  data$prestige[3] - as.numeric(model$coefficients[1]) - (data$schooling[3] * as.numeric(model$coefficients[2]))
)

data

# Let's check we did it right...
data$error # manual way.
model$residuals # "automatic" way.

# Let's create the vector for the intercept.
# Notice: it's the same number for everyone, that's why they call it "constant."

data$intercept <- c(
  as.numeric(
    model$coefficients[1]
  )
)

# vector for the beta. The beta is a "scalar" (a single number).
# That's why it is not sub-indexed.

data$beta1 <- c(
  as.numeric(
    model$coefficients[2]
  )
)

# let's check the data
data

# Let's show the same in the whiteboard.

#######################################################
# Some more about predicting
#######################################################

# let's create X
x=data$schooling

# let's create Y
y=data$prestige  

# let's estimate the model
lm.out <- lm(y ~ x)

# Now, let's create a sequence within a certain range of X.
newx = seq(min(x),max(x),by = 1) 

# Let's predict for the new sequence of numbers of X
conf_interval <- predict(lm.out, newdata=data.frame(x=newx), interval="confidence", level = 0.95) 

# Let's plot the relationship between Schooling and Prestige.
plot(x, y, xlab="Schooline", ylab="Prestige", main="Regression", ylim = c(30,90))
abline(lm.out, col="lightblue")
lines(newx, conf_interval[,2], col="blue", lty=2) # lower bound
lines(newx, conf_interval[,3], col="blue", lty=2) # upper bound



#################################################################
# This method is called OLS, for "ordinary least square", why?
#################################################################

# Because the estimated betas minimize the sum of the "squared errors."
