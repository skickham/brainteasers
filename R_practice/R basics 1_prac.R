#Question 1

#import TimesSquareSignage into R
#1.1
TimesSquareSignage = data.frame(read.csv('Introduction to R Part I Homework/TimesSquareSignage.csv'))
dim(TimesSquareSignage)  #dim() gives rows = #observ, col = #variables

#1.2
str(TimesSquareSignage)  #gives col title with type (int, num, or factor)

#1.3
sum(is.na(TimesSquareSignage)) # better way to find number of missing values
                              #summary(TimesSquareSignage) # lists Na's by column, should I just add these altogether?? Or is there a simpler way?? --> logical test

#1.4
rownames(TimesSquareSignage)[rowSums(is.na(TimesSquareSignage)) > 0] # gives the names of rows which have a missing value
                              #length(rownames(TimesSquareSignage)[rowSums(is.na(TimesSquareSignage)) > 0])  #gave 167 observ which have missing values
                              #TimesSquareSignage[is.na(TimesSquareSignage), 1:2]  # this gives a NA dataframe but it doesnt tell which rows ?????
colnames(TimesSquareSignage)[colSums(is.na(TimesSquareSignage)) > 0] #gives col names in which the sum of ANs by col is >0
                              #summary(TimesSquareSignage)     # shows columns which have NAs but is there a better way

#Question 2
#2.1
UpperBway = TimesSquareSignage[TimesSquareSignage$Location == 'Upper Bway', ]
write.csv(UpperBway, file = 'UpperBway.csv', row.names=F)

#2.2
MoreSquareFt = TimesSquareSignage[TimesSquareSignage$SF > mean(TimesSquareSignage$SF), ]
write.csv(MoreSquareFt, file ='MoreSquareFt.csv', row.names=F)

#2.3
TopTen = TimesSquareSignage[order(TimesSquareSignage$TOTAL.SF) , c(1, 2, 4)][1:10,]
write.csv(TopTen, file = 'TopTen.csv', row.names = F)

#Question 3
#3.1
data(cars)     #import dataset cars

#3.2
head(cars, 5)    #print first 5 lines

#3.3
state = sample(c('NY', 'CA', 'CT'), size = nrow(cars), replace = T)      #randomly generate state vector, nrow gives observations of dataset

#3.4
cars$state = state             #OR cars2 = cbind(cars,state) #combine state with cars

#3.5
cars$ratio = cars$dist/cars$speed     #adds new column ratio as a function of two other cols
mean(cars$ratio)         #average ratio
sd(cars$ratio)           #standard deviation ratio

