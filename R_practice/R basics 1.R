a = 1
b = 2
c = 3
print(a)
print(b)
print(c)
ls()
?lm
rm(list = ls())
### Your code here!
# 1. Calculate 5 / 2
x1 = 5/2

# 2. Calculate 5 %/% 2 
x2 = 5 %/% 2

# 3. Calculate 3 to the power of 5 %/% 2.
x3 = 3 ** x2

# 4. Calculate -3 to the power of 5 %/% 2.
x4 = (-3) ** x2
x_1 = rnorm(1,10)
x_2 = seq(1,10)
x = 1:4
x >= 2
x[x >= 2 & x < 4] # fancy indexing

# 5. Calculate -3 to the power of 5 / 2.
x5 = (-3) ** x1

int2 = seq(2,100, by=2)# fill your code here

int3 = seq(3,100, by=3)# fill your code here

int6 = sort(intersect(int2, int3))# fill your code here

int23 = sort(union(int2, int3))# fill



x = rnorm(10000)# fill your code here

y = sample(x, size = 100, replace = FALSE)# fill your code here
           
z = mean(x) - mean(y)# fill your code here # should be small due to random sampling and norml distribution
           
my_mat = matrix(1:12, 4, 3)   #fill in by column
print(my_mat)
          

Pet=list(species=c('dog','cat','dog'),weight=c(20,10,40))
avg_weight = mean(Pet$weight)# fill your code here
Pet$weight = Pet$weight+2

sapply_sd = sapply(iris[,1:4], sd)# use sapply   #makes series/ type == numeric()
lapply_sd = lapply(iris[,1:4], sd)   # makes type == list

### Your code here!
days = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
# construct string here, do not assign the value to variables, just print it
paste(days, collapse = " < ")

#Exercise 1 in RDA 2
generate_email <- function(name) {
  name_vec = unlist(strsplit(name, " +"))   # create list by splitting apart name string by 1 or more spaces between words
  y = paste(name_vec,'@gmail.com', sep="", collapse=';')
  # take each item in list and connect to @gmail.com without any space separating it, collapsing all the final results with semicolons
  return(y)# fill in your code here
}

### write your code here
generate_email <- function(name) {
  name_vec = unlist(strsplit(gsub("^\\s+|\\s+$", "", name), " +"))  # what is this catchall gsub?
  y = paste(name_vec[name_vec != ""], '@gmail.com', sep="", collapse=';')
  return(y)# fill in your code here
}
### Your code here!
days = c("Friday", "Sunday", "Monday", "Sunday", "Wednesday")
days = factor(days, c('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), ordered= T)
#why do we facto again?


range = quantile(iris$Petal.Length, c(0, 0.25, 0.75, 1.))
petal.length = cut(iris$Petal.Length, range)
levels(petal.length) = c('Short','Middle', 'Long')
petal.length = relevel(petal.length, ref = 'Middle')
petal.length = relevel(petal.length, ref = 'Long')
petal.length

Y = 1907
if ((Y%%4 == 0 & Y%%100 != 0) | Y%%400 ==0) {
      cat(Y, 'is a leap year')
} else {
  cat(Y, 'is not a leap year') 
}

### Your code here!
library(dplyr)
input_x = data.matrix(select(iris, -starts_with('Species')))
# fill your code here

### Your code here!
library(dplyr)
# save the 3 variabels as: minSepalLength, maxSepalLength and medSepalLength
# replace "?" with your code
summarise(filter(iris, Species == 'setosa'), 
          minSepalLength = min(Sepal.Length), 
          maxSepalLength = max(Sepal.Length), 
          medSepalLength = median(Sepal.Length))

### Your code here!

births = read.csv('/data/births.csv', stringsAsFactors=FALSE)
library(dplyr)
library(ggplot2)


births = inner_join(filter(births, sex=='boy'),filter(births, sex=='girl'),by='year')
#print(births)

births2 = mutate(births, total = births.x + births.y)
births3 = mutate(births2, percb = births.x/total, percg = births.y/total)
#print(births3)

g <- ggplot(data=births3, aes(x = year))
g + geom_point(aes(y=percb, color = sex.x)) + geom_point(aes(y=percg, color=sex.y))

