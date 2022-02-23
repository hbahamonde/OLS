# Basis functions: mean, help(), operators, objects (character, arrays, dates, lists and data.frames)


cat("\014")
rm(list=ls())

# 1+2
## This line is a "comment." It doesn't do anything at all.
## Now, highlight it, and run it ("Run" button) . 
## It will just show in the Console without doing anything.

## However, if you remove the comment, the next line will be run 
## Now you run the following lines. 
3+3

10/2

10^2

(3+3)/2

##################
## Packages
##################

## Installing Packages
install.packages("ggplot2") # This line installs a "library" called "ggplot2" that makes plots. 
library(ggplot2) # And this line "calls" this library so we can use it.
## NOTE: If you want to use a library/package, you need to make sure you have it installed first.
## If you do, then you just need to call the library as in "library(ggplot2)".

## There is also another way to do the same.
## Go to "Packages" and search for "ggplot2"
## If the package is installed, checking the library replaces "library(ggplot2)"
## Now, let's detach the library (by unchecking), and then uninstall the whole library ("x").


##################
## Asking R for help
##################

# Issue: you need to create a sequence of numbers, for instance, from 1 to 10.
# Maybe a good idea is to assume that our function might be called (or contain)
# the word "seq". You actually don't know the name of the package/function.
# Let's ask for help...
help(seq)
help(sequence)

# Now we know that there are actually two packages that might do the job.
# "seq" and "sequence".

# Now, as you can see, the "Help" tab will open. Let's read that...
# Ok, now that we know how to use the "seq" function, let's use it.

seq(from = 1, to = 10)

# Note that there is a comma between "arguments" (internal parts that this function accepts).

# Now, lets suppose we need a sequence by two's. Let's use the argument "by".

seq(from = 1, to = 10, by=2)

# How about a decreasing sequence, by 2?
seq(10, 1, -2)

# Notice that the sequence goes "from" the largest value "to" the smallest value.
# Notice also that we did not specify "from" nor "to". 
# As long as you preserve the order of the arguments, the package will "know" what
# you're talking about.

# OK. Enough with sequences. Let's see "repetitions."
# "help(seq)" assumes that you know that the function should be called (more or less)
# "seq". However, what if you have no clue about the name of the function?
# For sure we know that the first place to start looking for "repetitions" should
# contain "rep," for "repeat" or "repetition" or "repeated"...

# Let's do a more general search...
??rep
# Now let's look for "Replicate Elements of Vectors and Lists". This is in the "base" of R (the core and basic R functions that come with it).
# Now, let's use this function, and repeat something...
rep("May the force be with you", 100)

# Let's try to combine "seq" and "rep" by using a "nesting coding structure" (a function within another function).
rep(seq(1, 4, 1), 5)

##################
## Objects
##################

# One of the many advantages of R is that it is an "object-oriented" piece of software.
# Unlike state, for instance, you can store in your memory several datasets, numbers, strings, etc. Stata, for instance, can only handle one dataset at a time.
# Let's create an object.
abc <- 3

# We've just created an object called "abc" which has a number "3" inside it.
# Now, let's call the "abc" object...
abc

# Notice that the Console shows "[1] 3". This means that there is only one line, hence "[1]".

# Now let's create an object that contains text, or "characters."

three <- "four"

# Now let's call the object "three"...
three

# Notice that characters always go with quotation marks... ""
# Let's take advantage of this situation, and let's transform the number 3 in text
three <- "3"

# Now "3" is text instead of a number. Let's (try to) use it...
three + three

# Ups...something went really wrong...

# Let's fix it..
three <- 3

three + three

# Let's keep trying different alternatives...

three.sq <- three^2

three.sq

# Let's check the "Environment". This window contains all the things we've created.
ls()

# Let's delete (remove, "rm") them all.
rm(list=ls())

# And let's check everything is empty...
ls() # nothing to see here...


##################
## Other objects: Vectors
##################

# Numeric vector
vector.n = c(1,2,3,4)
vector.n
## In this vector, we've included four numbers. It's a numeric vector.

# Vector of text
vector.t = c("one", "two", "three", "four")
vector.t

# Let's multiply some vectors...[represent this in whiteboard].
vector.n.2 = vector.n*2
vector.n.2

# Let's check vector.n.2 > vector.n
vector.n.2 > vector.n

# Let's check the second elements in our vector...
vector.n.2[2]


##################
## Other objects: Lists
##################

# let's create a list. this type of object is really flexible and allows us having different kinds of elements inside of it.

my.info <- list(
  class=c("Intro to Epistemology", "Quant Methods", "Political Theory"),
  prof=c("X", "HB", "Y"),
  WhatsApp="+358-123456789"
)

# lets check the second element of the list (prof)
my.info[[2]] # check double square-brackets!

# lets check now but using the subclass, 
my.info$class

# lets check now the second element of the second subclass 
my.info$prof[2]

# Notice that the lenght of each subclass may be different!

##################
## Other objects: Matrix
##################

# let's create a matrix whose scalars (fancy word for "number" in the matrix algebra jargon) follow a sequence from 1 to 6, and put them in two rows.
a <- matrix(1:6 , nrow=2)
a

# row 2 column 3
a[2,3]

# all rows column 2
a[ ,2]

# all columns row 1
a[1,]

##################
## Other objects: Dates
##################

a = as.Date('1/15/2001',format='%m/%d/%Y')
b = as.Date('1/16/2001',format='%m/%d/%Y')
c = as.Date('1/17/2001',format='%m/%d/%Y')

# Now R "understands" that some dates are larger (older!) than others ("more recent"). 
a>b

##################
## Other objects: data.frame
##################


dataset <- data.frame(
  diabetic = c(TRUE, FALSE, TRUE, FALSE), 
  kilos = c(65, 69, 71, 73),
  name = c("A", "B", 'C', "D")
)

# let's describe "the head" of the dataset
head(dataset)

# let's inspect the dataset using something like Excel
View(dataset)

dataset[3,2] # row 3, column 2

dataset[1:2, "kilos"] # Let's filter using the name of the column instead of the number. For the rows we will use the sequence of the first two elements. 

dataset[ ,"diabetic"] # let's filter all rows for all observations in the "diabetic" column.

## let's inspect the column names of the data.frame
colnames(dataset)

## Ups, let's pretend you have just discovered it wasn't "kilos" but "age". Let's change the name of that column.
colnames(dataset) <- c("diabetic", "age", "name")

## Let's check...
dataset
colnames(dataset)

## Summary of the df
summary(dataset)

## Now let's call the "Prestige" data
install.packages("car") # install the dataset that lives in the "car" library.
library(car) # now let's load the dataset

## Let's insepct the dataset.
View(Prestige)
head(Prestige)

## Let's summarize the dataset.
summary(Prestige)

### education: Average education of occupational incumbents, years, in 1971.
### income: Average income of incumbents, dollars, in 1971.
### women: Percentage of incumbents who are women.
### prestige: Pineo-Porter prestige score for occupation, from a social survey conducted in the mid-1960s.
### census: Canadian Census occupational code.
### type: Type of occupation. A factor with levels (note: out of order): bc, Blue Collar; prof, Professional, Managerial, and Technical; wc, White Collar.


## If/else function.
Prestige$prestige.2 <- ifelse(Prestige$prestige > mean(Prestige$prestige), "high","low")

## Tags:
is(Prestige$type) # "what is"?

levels(Prestige$type) # What labels does it have?

## Recode:
install.packages("plyr") 
library(plyr)
Prestige$type.2 <- revalue(Prestige$type, c("bc"="Technical", "prof"="Professional", "wc"="Office Job"))
