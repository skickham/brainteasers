#store a variable in here then rename it in the console, if source save again, the variable canges back
#?____ gives help on any functions, e.g. ?sin
#or type function then wait a sec and it will pop up with brief help
#?pi gives built in constants for R
#exp(1) == e
#class() of an object tells you data type --> very helpful in debugging!
# single or double quotes do same thing
# less than signs work in alphabetical order too, aA --> zZ
#create a vector using "combine function" i.e. c(1,2,3,4)

#quick ways to create vetors: seq(lower, upper, by=step, length = # of objects including both bookends)
#rnorm(# of values wanted) --> gives # values with mean 0 and std. dev 1
#__*runif(#)--> gives # of values uniformly distributed from 0 to 1 (or whatever number you multiply by)
# if want to replicate a random sample of a vector then type:
# set.seed(some unique #); sample(c('A', 'B'), size =20, replace =T) 
# Then can replicate by typing out same set.seed in the future.
#vector by repition: rep(c(vals to be repeated),c(number of times to repeat each val))

#vector slicing
#x[index]
#x[c(vector)]
#x[seq(lower, upper, by = step)]
#x[c(logical vector)] --> can be of length less than total vectors length, will just repeat
#x[c(negative numbers)] --> gives everything except those indices
#x[x <=2 ] --> slicing with logical test!!

#can create seq by: x = 10:15

#can get logical vectors by comparing vectors element-wise: c(1,2,3,4) >= c(4,3,2,1)

#pointwise functions such as sqrt(vector), exp(vector)
#aggregating functions of vectors: mean, max, min, sd, length, summary

#Exercise 1
getwd()
setwd('C:/Users/skick/Desktop/NYC Data Science Academy/Class_R')
?lm
ls() #prints all named values in the working environment
rm(list = ls())

#Exercise 2
x = 'Hello, I am'
y = 'Sean'
cat(x,y)

#Exercise 3
5 / 2
5 %/% 2 # gives floor division
3 ^ (5%/%2) # 3 squared = 9
(-3) ^ (5%/%2) # -3 squared = 9
(-3) ^ (5/2) # (-3) to 2.5 = Nan
# last one return NaN maybe because it can't do square roots

#Exercise 4
x = '8'
class(x)
#x+1      #error because a char cant be added
as.numeric(x) + 1
x = as.numeric(x)
x = x+1 #9

#Exercise 5
x_1 = rnorm(5)
x_2 =1:10

#Exercise 6
x_3 = x_2[1:5]   # or x_3 = x_2[seq(1,5)]

#Exercise 7
my_sum = x_1 + x_3
x_1[3] * x_1[1]
#x_1 + c(1,2) #length error since length(x_1) = 5, and is not mult of 2



#MATRICES
#a matrix is a vector with dimensions
my_mat = matrix(1:12, 2, 3)
#or dim(vector) = c(ROWS, COLS) changes vector into a matrix
#or combine vectors to make a matrix rbind/cbind(vector1, vec2, vec3)
#--> but they must be of same length
# matrix slicing is same as vector slicing, just first for rows and then for columns
# if select single row or single col, it becomes a vector, but if want still the matrix type, add argument to slice: drop = F
#modifying/assigning new vals works same as vector, just be careful with lengths

#ARRAYS
#similar to matrix
a <- array(1:24, dim = c(3,4,2))
#slicing and everything else is same
b<- array(1:120, dim = c(5,4,3,2))

#Exercise 8
m_1 = matrix(1:6, 2, 3)
m_2 = matrix(7:18, 4, 3)
m_3 = rbind(m_1, m_2)
m_3

#Exercise 9
my_mat2 = matrix(1:9, 3, 3, byrow=T)
#the numbers increase going across the rows rather than down the columns
#because of the byrow = T
prod_mat = my_mat2[1,] * my_mat2[,2]


#DATAFRAMES
#can have multiple data types in a single table
#data.frame(newcolname = vec1, newcolname = vec2, row.names =c(rownames))
#rownames(dataframe) = vec
#colnames(df) = vec
# slicing works same way! ==> logical tests can be very helpful here
#--> logical test: citydf[citydf$CITY == 'New York City', ]
#-----> notice the $ format and the , follwed by nothing to return all columns of those selected rows
#as.data.frame(vector or matrix or slice of df)
#can apply function to numeric columns

city = c('Seattle', 'Chicago', 'Boston', 'Houston')
temp = c(78,74,50,104)
citydf = data.frame(city, temp)


#functions: dim(), head(df, #), str(df) *structure of dataframe*, 
#           summary(df) *quartile info*
#           order(df$colname, decreasing = F) , i.e. citydf[order(citydf$temp), ] **alpha or num**
#           View(df[slice])   * gives doc view of sliced df

#Exercise 10
Pet <- data.frame(Species = c('dog', 'cat' , 'dog'), weight = c(20, 10, 40))
#Exercise 11
Pet[Pet$Species == 'dog', ]
#Exercise 12
data1 = data[order(data$city, decreasing = T),]
str(data1)
#structures are the same levels and numbers, just in a diff order

#Exercise 13: LISTS!
Pet = list(Species = c('dog', 'cat', 'dog'), weight = c(20,10,40))
#Exercise 14
mean(Pet$weight)
Pet$weight = Pet$weight + 2   #OR:  Pet$weights = Pet[[2]] + 2


#Exercise 15: APPLY FUNCS
sapply(iris[,1:4], sd)
lapply(iris[,1:4], sd)



#HOMEWORK

#Question 1
#import TimesSquareSignage into R
TimesSquareSignage = data.frame(read.csv('Introduction to R Part I Homework/TimesSquareSignage.csv'))
dim(TimesSquareSignage)  #dim() gives rows = #observ, col = #variables
str(TimesSquareSignage)  #gives col title with type (int, num, or factor)
#summary(TimesSquareSignage) # lists Na's by column, should I just add these altogether?? Or is there a simpler way?? --> logical test
sum(is.na(TimesSquareSignage)) # better way to find number of missing values
TimesSquareSignage[is.na(TimesSquareSignage), 1:2]  # this gives a NA dataframe but it doesnt tell which rows ?????
summary(TimesSquareSignage)     # shows columns which have NAs but is there a better way

#Question 2
UpperBway = TimesSquareSignage[TimesSquareSignage$Location == 'Upper Bway', ]
write.csv(UpperBway, file = 'UpperBway.csv', row.names=F)
MoreSquareFt = TimesSquareSignage[TimesSquareSignage$TOTAL.SF > mean(TimesSquareSignage$TOTAL.SF), ]
write.csv(MoreSquareFt, file ='MoreSquareFt.csv', row.names=F)
TopTen = TimesSquareSignage[order(TimesSquareSignage$TOTAL.SF) , c(1, 2, 4)][1:10,]
write.csv(TopTen, file = 'TopTen.csv', row.names = F)

#Question 3
data(cars)     #import dataset cars
head(cars, 5)    #print first 5 lines
state = sample(c('NY', 'CA', 'CT'), size = nrow(cars), replace = T)      #randomly generate state vector, nrow gives observations of dataset
cars$state = state             #OR cars2 = cbind(cars,state) #combine state with cars
cars$ratio = cars$dist/cars$speed     #adds new column ratio as a function of two other cols
mean(cars$ratio)         #average ratio
sd(cars$ratio)           #standard deviation ratio

