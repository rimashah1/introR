# Intro to R

# Interacting with R
# Add 3 + 5
3.5

## Variables
x <- 3 # Alt + - = <- 
y <- 5

x <- 5
y <- 10
x + y
number = x + y # rerun to show updated values of x and y
number


### Data Types ###
# numeric- whole or decimal numbers
# integer- whole numbers
# categorical- strings '''' around the value
# logical- Boolean- TRUE, FALSE, T, F



### Data Structures ###

## Vectors- must all be the same data type
# A vector is a single entity that has elements. Each element has 1 value
glengths <- c(4.6, 3000, 50000)
species <- c("ecoli", "human", "corn")
combined <- c(glenths, species) # Numeric values are now categorical


## Factors- type of vector that stores categorical values
# Each category is called a factor level. Factors are built on top of integer vectors such that each factor level is assigned an integer value, creating value-label pairs.

expression <- c("low", "high", "medium", "high", "low", "medium", "high")
expression <- factor(expression)

samplegroup <- c("CTL", "KO", "OE")
samplegroup <- factor(samplegroup)


## Matrix- collection of vectors in a 2D structure
# Vectors in a matrix have same length and data type

## Data frames- similar to matrix, but each vector can be a different data type
df <- data.frame(glenths, species)

titles <- c("Catch-22", "Pride and Prejudice", "Nineteen Eighty Four")
pages <- c(453, 432, 328)
df_books <- data.frame(titles, pages)


## Lists- can hold any number of any type of data structure
list1 <- list(species, df, number )
list2 <- list(species, glenths, number)



### Functions ###
glengths <- c(glengths, 90) # add value to end
glengths <- c(30, glengths) # add value to beginning

sqrt(81)
sqrt(glengths)

round(3.14159)
?round
args(round)
example("round")
round(3.14159, digits=2)

mean(glengths)
test <- c(1, NA, 2, 3, NA, 4)
mean(test, na.rm=TRUE)
sort(glengths, decreasing = T)


# writing new functions
square_it <- function(x) {
  square <- x * x
  return(square)
}
square_it(5)

multiply_it <- function(x, y) {
  multiply <- x * y
  return(multiply)
}
multiply_it(4, 5)



### Reading Data into R ###
metadata <-  read.csv('data/mouse_exp_design.csv')

proj_summary <- read.table(file='data/project-summary.txt', header=TRUE, row.names = 1)


### Inspecting data structures ###
head(metadata)

class(glengths)
class(metadata)

summary(proj_summary)

length(samplegroup)

dim(proj_summary)

rownames(metadata)
