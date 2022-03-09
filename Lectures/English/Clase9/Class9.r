# The "mechanics" behid OLS (II): Matrix Algebra in R

cat("\014")
rm(list=ls())
graphics.off()

# define x
x = matrix(
  c(1,1,1,2,7,3,2,4,6),
  nrow = 3, 
  ncol = 3
  )

x

# define y
y = matrix(
    c(3,5,7),
  nrow = 3, 
  ncol = 1
)

y
###########################
# traspose x with "t" function
###########################
t(x)

###########################
# multiply transposed x times x: x'x
###########################
t(x) %*% x

###########################
# take the inverse
###########################

## first, find the determinant
# det(t(x)%*%x)
# 324

## second, find the adjacent

# Let's do this process directly. Let's invert x'x

solve(t(x)%*%x)

###########################
# Model
###########################

# In matrix form: b = (x'x)-1*x'y
options(scipen=99)
solve(t(x) %*% x)%*%t(x)%*%y # beta

b = round(solve(t(x) %*% x)%*%t(x)%*%y, 0)
b

# Luckily the function "lm" does all these (and more!) automatically.
data = data.frame(
        x=x[,2:3],
        y=y
        )

data

model = lm(y ~ x.1 + x.2, data) # "lineal model"
summary(model)
