#HOMEWORK
#Question 1: Fibonacci sequence upto 4 million

#s = c(1,2,3)
#i = 3
#while (s[i-1] < 4E6) {
#  s[i] = s[i-1] + s[i - 2]
#  i = i + 1
#}

s= c(1,2)
i = 2
while (s[i]<4e6) {        #this loop only needs 2 starting values in the vector 
  s[i+1] = s[i] + s[i-1]   #fill in s[i+1], looking forward
  i = i+1
}
sum(s[s%%2 == 0])      #summing all numbers in list divisible by 2 => 4,613,732

###
#evenFibNumSum = function(fnum){
 # fibSum = 0
  #fibNum = c(0,1)
#  while (TRUE){
    temp = sum(fibNum)
    fibNum[1] = temp + fibNum[2]
    if(fibNum[1] > fnum)
      break;
    fibNum[2] = temp + fibNum[1]
    fibSum = fibSum + fibNum[1]
  }
  
  return (fibSum) # () required
}
evenFibNumSum(4e6)

#Question 2: multiplying matrix by vector
mymat = matrix(1:24, 6, 4)       #choose an m*n matrix
myvec = 1:4                      #choose a vec of length n
y = c(); i = 1                   #initialize i and empty vector

for (i in 1:nrow(mymat)){        #go through each row of the matrix 
  j = 1:length(myvec)            
  y[i] = sum(mymat[i, j]*myvec[j])     #each item in the answer is the sum of the rpoduct of the row by the vector
  i = i+1
}

#Or create a matrix multiplication operator
'%mat*%' = function(mymat, myvec){
  y = c(); i = 1                   #initialize i and empty vector
  for (i in 1:nrow(mymat)){        #go through each row of the matrix 
    j = 1:length(myvec)            
    y[i] = sum(mymat[i, j]*myvec[j])     #each item in the answer is the sum of the rpoduct of the row by the vector
    i = i+1
  }
  print(y)
}

mymat %mat*% myvec






#Question 3: Median Absolute Deviation Function
x = seq(3, 100, by=.5)

MAD = function(x) {
  y = c()                            #initialize empty vector
  for (i in 1:length(x)) {           #for each item in vector x
    y[i] = abs(x[i] - median(x))       #abs val of the  diff of the item and the median of the vector, and put in empty list
  }
  return(median(y))                  #make sure the function returns the MAD value, i.e. median of the new list
}

MAD(x)


#Question 4: Email output
Names <- "John Andrew Thomas"      #initiates names variable
x = strsplit(Names, split=' ')[[1]]    #split names into vactor by name
paste(x, c('@gmail.com'), sep = '', collapse = '; ')    #pastes '@gmail.com' to each item without a space in between (sep ='') and then collapses them with a semicolon and space






#Question 5: generate cat vector WITHOUT loops
x = rep(c('a','b','c','d','e'), rep(5,5))
y = c('a', 'b', 'c', 'd', 'e')
paste(y, x, sep ='')

x= c('a','b','c','d','e')
x1= as.vector(outer(x,x,paste0))
x1
# another solution
list <- c("a","b","c","d","e")
c(sapply(list, paste0, 'list$'))

?use.names
