#CHARACTERS
fruit = 'apple orange grape banana'
nchar(fruit)
strsplit(fruit, split = ' ')     #split string along defined regex, does not include split object
strsplit(fruit, split = ' ')[[1]]
fruitvec = strsplit(fruit, ' ')[[1]]   #change it to a vector (double brackets)
strsplit(fruit, split= 'a')
paste(fruitvec, c('A', 'B'))   #paste works on vectors to concatenate something on the end of each item, will recycle
paste(fruitvec, c('A', 'B', 'ZZZZZ'), sep = '::-->')     #sep is space by default
paste(fruitvec, collapse=',')     #combine items together in one string
paste(fruitvec, c(' is a fruit'), sep = ':', collapse ="@")

n = 1:8
xvar= paste0('x', n)      #paste zero concats each item with x and puts no space between
xvar
right = paste(xvar, collapse = ' + ')     #collapse all them to addition function
form = paste('y ~' , right)    #paste with y at beginning
paste('y~', xvar)  #with list, adds y~ to each item

#SUBSTRINGS
substr(fruit, 1, 5)   #char[1]-[5]
substr(fruitvec, 1, 3)  #char 1:3 in each item

gsub('apple', 'strawberry', fruit)   #nonmutating --> replaces apple with strawb in string fruit
gsub('apple', 'strawberry', fruitvec)    #works in lists too

grep('grape', fruit)     #in a string, it just returns a 1 if it has it, not helpful really
grep('grape', fruitvec)
grep('a', fruitvec)    #returns all indices numbers for items that have an 'a'
grep('an', fruitvec)

#Exercise 1
mychar = 'R is great! I love data!'     #save str to var
substr(mychar, 6, 10)                   #find substring by index
mycharlist= strsplit(mychar, split = ' ')[[1]]   #split into list (double brackets!!!)
grep('love', mycharlist)                #find word location of string (now a list)
gsub('great', 'wonderful', mychar)      #replace great with wonderful in the original string

words = unlist(strsplit(mychar, split = ' '))    #unlisting is other option for splitting
grep('love', words)


#FACTORS
species = iris$Species
class(species)  #factors --> as with all char cols in dfs
levels(species) #gives diff categories
class(levels(species))  #levels are chars
as.character(species)   #changes to characters

ranks = c(4,1,1,4,3,3,2,3,2,4)
rank_factor = factor(ranks)     #converts to numbers to factors! (and chars)
rank_factor
levels(rank_factor)      
#can no longer apply arithmetic to the factors

#can create levels quickly with repeat function for vec, factors func, levels re-assignment
vec1 = factor(rep(c(0,1,3),c(4,6,2)))
levels(vec1) = c('male', 'female', 'male')

vec2 = factor(rep(c('b', 'a'), c(4,6)))
vec2
levels(vec2)
vec2_ordered = ordered(vec2, levels = c('b', 'a'))    #levels ordered alphabetically, reorder them if desired
levels(vec2_ordered)  #lists 'b' first now --> this is mainly useful for graphing purposes, to place certain bars next to each other


#CONTROL STATEMENTS
#CONDITIONALS
 
num =5                    #pre-assigned var
if (num %% 2 != 0) {      #if (condition) {
  cat(num, 'is odd')      #function, what to do  (TRUE branch)
} else {                  #else on same line beteen curly braces
  cat(num, 'is even')     #function to implement otherwise  (FALSE branch)
}                         #cat > paste here because its efficient and just prints, rather than converting to a char string


num = 15
if (num %% 2 != 0) {
  if (num %% 5 == 0) {
    cat(num, 'is divisible by 5')
  } else {
    cat(num, 'is odd, but not divisible by 5')
  }
} else if (num == 0) {                                       #else if, allows for multiple possibilities at the same level
  cat(num, 'is even, although you may not realize it.')
} else {
  cat(num, 'is even')
}

if (num %% 2 != 0)            #shorter syntax for one-statement branches
  cat(num, 'is odd') else     #else must be on same line
    cat(num, 'is even')

lv = c(T, T, F, T, F)   #logical vector
v1= c(1,2,3,4,5)
v2=c(11,12,13,14,15)
ifelse(lv, v1, v2)       #if lv is true, return the value in vector 1, if false, return the second vector

v3 = c(5,4,3,2,1)
ifelse(v1>v3, v1, v3)     #the logical test creates the logical vector and returns appropriate response

num = 1:6
ifelse(num %%2 ==0, 'even', 'odd')   #if a number is divisible by 2, call it even, otherwise odd

set.seed(1)   #reproducible results
age = sample(0:100, 20, replace = T)     #random sample of ages with replacement
result = ifelse(age>70, 'old', ifelse(age <=30, 'young', 'middle'))     #ifelse for three categories of age (nested ifelse)

switch(1, 'Red', 'Orange', 'Blue')     #useful if you have over 3 conditions
switch(2, 'Red', 'Orange', 'Blue')  
switch(3, 'Red', 'Orange', 'Blue')       #more efficient than c('Red', 'Orange', 'Blue')[1] b/c doesnt look through every option

age_type = 'middle'
switch(age_type,                         #switch fro strings uses keywords
       young = age[age <= 30],           #the variable contains the string
       middle = age[age <= 70 & age > 30],     #each choice reps different IDs the string can take
       old = age[age > 70]                 # in this case, it outputs the list of ages from our original vector that falls in that category
)


#Exercise 3
income = c(4600, 123000, 4999, 5000)
ifelse(income < 5000, '10%', '20%')      #shows tax bracket 
ifelse(income < 5000, income*0.1, income*0.2)    #shows amount to pay in taxes
Grade = c(75, 93, 88, 80, 99, 75, 76, 92)
Choice = 'A'
switch(Choice,
       A = Grade[Grade >= 90],       #it didnt say >= but it just makes sense
       B = Grade[Grade >= 80 & Grade < 90],
       C = Grade[Grade >= 70 & Grade < 80])

#so, does switch relay tall the items in the list 
#that fall in a certain category, 
#while ifelse returns the categories of each item in a list??

#FOR LOOPS
sign_data = read.csv('C://Users/skick/Desktop/NYC Data Science Academy/Class_R/Introduction to R Part I Homework/TimesSquareSignage.csv', header = T)
for (x in sign_data$Width) {
  if (is.na(x)) {
    cat('WARNING: Missing width\n')
  }
}

obs = nrow(sign_data)                # nrows = obs
for (i in 1:obs) {                   # iterate over vector c(1, 2, ., obs)
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')     #need the newline at the end
  }
}

#WHILE LOOPS 
#WARNING: be careful of infinite loops
i = 1
while (i <= obs) {                      #same as for loop above, just harder
  if (is.na(sign_data$Width[i])) {
    cat('WARNING: Missing width for sign no.', i, '\n')
  }
  i = i + 1
}


sum = 0
number = 1
while (TRUE) { #This creates an infinite loop...
  if (sum > 10) {                       #could put this statement as the terminating condition in the while loop
    break #...but the break statement saves us!
  }
  sum = sum + number
  number = number + 1
  print(paste("sum is:", sum, "number is:", number))
}

s = c()
v = 1:5
for (i in 1:length(v)) {
  s[i] = v[i]^2
}


#LOOP EFFECIENCY
#create function to test for prime:
prime.checker = function(x) {
  if (x %in% c(2, 3, 5, 7)) return(TRUE)
  if (x %% 2 == 0 | x == 1) return(FALSE)
  xsqrt = round(sqrt(x))
  xseq = seq(from = 3, to = xsqrt, by = 2)
  return(all(x %% xseq != 0))           #all only returns true if ALL values are true, it's prime b/c its not divisible by anything, i.e. there is never a remainder of 0 
}

system.time({
  x1 = c()
  for (i in 1:1e4) {
    y = prime.checker(i)
    x1[i] = y         #adds y to vec x if y returns TRUE from prime.checker function
  }
})

system.time({
  x2 = logical(1e4)
  for (i in 1:1e4) {
    y = prime.checker(i)
    x2[i] = y
  }
})


#When to use EXPLICIT LOOPS



system.time({
  x3 = sapply(1:1e4, prime.checker)
})

#Exercise 4
sum =0
for (i in 1:100){
  sum = sum + i^2
}
print(sum)

sum = 0
v = 1:100
sum = sum(v^2)

v = 1:100
sumofsquares = 0
for (i in 1:length(v)){
  sumofsquares = sumofsquares + v[i]^2
  i = i + 1
}
sumofsquares

v = c(3,5,6)  #followed by same for loop from above

v = 1:100
summ = 0
for (i in v) {
  summ = summ + i
  cat(summ, '\n')
}

#Exercise 5
ss2 = 0
v = 1:100
i= 1
while (i <= 100){
  ss2 = ss2 + v[i]^2
  i = i+1
}

x = 100
r = x/2
i = 0
while (abs(x - r^2 > .001)) {
  r = (r+ x/r)/2
  cat('Iteration', i, 'r=', r, '\n')
  i = i + i
}



#Exercise 6
v = 1:50000
w = seq(5000, 1, -1)/(sum(1:50000))
sum(v*w)


#FUNCTIONS
calc_area = function(r) {
  area = pi * r^2
  return(area)
}
calc_area(4)

calc_area = function(r) {
  return(pi * r^2)
}

#create a function to calculate either the sample standard deviation or the population SD
SDcalc = function(x, type) {
  n = length(x); mu = mean(x)
  if (type == 'sample') {
    stdev = sqrt(sum((x-mu)^2)/(n-1))
  }
  if (type == 'population') {
    stdev = sqrt(sum((x-mu)^2)/(n))
  }
  return(stdev)
}
SDcalc(1:10, 'sample')
SDcalc(1:10, 'population')
 #Note: variables inside function only exist inside function, not in global environment
#can do a default parameter just by typing it into the arguments in function()
SDcalc = function(x, type = 'sample', ...) {
  n = length(x); mu = mean(x, ...)
  if (type == 'sample') {
    stdev = sqrt(sum((x-mu)^2, ...)/(n-1)) }
  if (type == 'population') {
    stdev = sqrt(sum((x-mu)^2, ...)/(n)) }
  return(stdev)
}



#DATA TRANSFORMATIONS
#SPLIT
iris_split = split(iris, iris$Species)
class(iris_split)
attributes(iris_split)
str(iris_split) 
iris_split[[1]]
iris_split[[2]]$Petal.Length


avg_petallen = function(x) {
  mean(x$Petal.Length)
}
lapply(iris_split, avg_petallen)

#UNSPLIT
iris_unsplit = unsplit(iris_split, iris$Species)
class(iris_unsplit)
test = rep(c('virginica', 'versicolor', 'setosa'),50)
head(unsplit(iris_split, test))

#Exercise 8
iris_split = split(iris, iris$Species)
quantile(iris_split[[1]]$Petal.Length, probs = .25)
quantile(iris_split[[1]]$Petal.Length, probs = .75)
quantile(iris_split[[2]]$Petal.Length, probs = .25)
quantile(iris_split[[2]]$Petal.Length, probs = .75)
quantile(iris_split[[3]]$Petal.Length, probs = .25)
quantile(iris_split[[3]]$Petal.Length, probs = .75)

for (name in names(iris_split)) {
  range = quantile(iris_split[[name]]$Petal.Length, c(0,0.33,0.66,1))
  iris_split[[name]]$range = 
    ifelse(iris_split[[name]]$Petal.Length < range[2], 'short',
           ifelse(iris_split[[name]]$Petal.Length > range(3), 'long', 'middle'))
}
unsplit(iris_split, iris$Species)

#OR
labels=c('Short','Middle','Long')
for(i in 1:3){
  tmp = iris_list[[i]]$Petal.Length
  range=quantile(tmp, c(0,0.25,0.75,1))
  iris$category=cut(tmp, breaks=range,labels=labels,
                    include.lowest=TRUE)}
unsplit(iris_split, iris$Species)





#ONLINE CODE: RDA Part 2
paste_chars <- function(char_vec){
  char_vec2 = rep(char_vec, each = length(char_vec))
  paste0(char_vec2, char_vec)# fill your code here
}

generate_email <- function(name) {
  name = strsplit(name, split = ' ')[[1]]
  paste(name, c('@gmail.com'), sep ='', collapse = ';')
}


#?????????????????????????? empty string
generate_email <- function(name) {
  name = strsplit(name, split = ' +')[[1]]
  if (length(name) == 0) {
    cat("") 
  } else {
    paste(name, c('@gmail.com'), sep ='', collapse = ';')
  }
}


#Prisoner's dilemma
f <- function(a, b){
  res = ''
  if (a == 'betray'){
    if (b == 'betray'){
      res = 'Each serves 2 years'
    } else {
      res = 'A: free; B: 3 years'
    }
  } else {
    if (b == 'betray') {
      res = 'A: 3 years; B: free'
    } else {
      res = 'Each serves 1 year'
    }
  }
  # wirte expression to assign the final convictions to variable 'res'
  return(res)
}


#gcd Iterator:
#first one found off internet, only on ethat works but don't understand it 
gcdIter <- function(a, b){
  r <- a%%b;
  return(ifelse(r, gcdIter(b, r), b))
}

div = min(a,b)
for (i in 0:div) {
  if (a %% (div-i) == 0 & b %% (div-i) == 0) {
    return(div-i)
    break
  }
}

while (a %% (div-i) == 0 & b %% (div-i) == 0) {
  
}


#???????????????????
generate_email <- function(name) {
  name = trimws(name)
  name = strsplit(name, split = ' +')[[1]]
  paste0(name, c('@gmail.com'), sep ='', collapse = ';')# fill in your code here
}





