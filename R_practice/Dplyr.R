setwd('C:/Users/skick/Desktop/NYC Data Science Academy/Class_R/')
births <- read.csv('Manipulating Data with dplyr/Manipulating Data with dplyr/births.csv', stringsAsFactors = FALSE)
births[c(1:2, 131:132),]

bnames <- read.csv('Manipulating Data with dplyr/Manipulating Data with dplyr/bnames.csv', stringsAsFactors = F)
head(bnames, 5)

mike = bnames[bnames$name == "Mike", ]
head(mike, 3)

vivian = bnames[bnames$name == 'Vivian', ]
head(vivian, 3)

df = data.frame(color = c('blue', 'black', 'blue', 'blue', 'black'),
                value = 1:5)
df
library(dplyr)

#FILTER: for selecting rows
filter(df, color == "blue")
df[df$color == "blue",]
filter(df, value %in% c(3, 4, 5))
filter(df, value %in% c(3, 4, 5) & color=='blue')     #logical operators
filter(df, value %in% c(1, 4) | color=="black")
filter(df, c(T,F,F,F,T))    #same as above, just showing the logical vector

#logical vectors must be same length as df

#SELECT: for selecting columns
select(df, color)
select(df, color, value)
select(df, -color)   #not color
select(df, 1)      #works but col names are more exact as df might change over time
select(df, -1, -2)
select(select(df, -1), -1) #works differently than immediate problem below
select(df, -1, -1)
select(df, -1, 1)    #switches order of columns
select(df, 2, 1)     #same thing as above
select(df, starts_with('c'))
select(df, contains('e'), starts_with('c'))
# ends_with(), matches() #regex, one_of()
select(df, COLOR=color)    #Renames color col to COLOR
rename(df, Something.New = value)   #works same way but returning entire df

#ARRANGE: choose col to run in ascending order
arrange(df, value)       #renumbers rows
arrange(df, color)     #alphabetical order
arrange(df, desc(value))   #make descending
select(arrange(df, color), color)


#MUTATE: create a new column
mutate(df, double = value*2) #uses vector element-wise multiplication to add new col
mutate(df, double = 2 * value, quadruple = 4 * value)
mutate(df, double = 2 * value, quadruple = 4 * double)   #can even use a newly created col to make another new col
mutate(df, quadruple = 4 * double, double = 2 * value)    #!doesn't work b/c double was named after quad.
transmute(df, double = 2 * value, quadruple = 4 * value)      #transmute only selects newly created cols rather than new & old


#SUMMARISe: allows you to create new cols with aggregate functions from columns
summarise(df, average_value = mean(value))
summarise(df, total = sum(value),            #multiple functions/cols at once
          avg = mean(value))
summarise(df, new_col=mean(value)/sd(value))
#min(), max(), mean(), sum(), sd(), median(), n() #number of observations
#n_distinct() # number of disctinct obs in col, first(), last()
distinct(df, color)    #names the distinct values
summarise(df, n_distinct(color))    #counts the distinct values
nth(x,n) # returns nth observation in column x
nth(df$color, 4)       #gives vector
summarise(df, nth(value, 2))   #gives df

#like sapply, but I think sapply can only do one function at a time where summarise can do multiple & distinct


#JOINS!!
x = data.frame( name = c("John", "Paul", "George",
                         "Ringo", "Stuart", "Pete"),
                instrument = c("guitar", "bass", "guitar",
                               "drums", "bass", "drums"),
                stringsAsFactors = FALSE)
x
y <- data.frame( name = c("John", "Paul", "George",
                          "Ringo", "Brian"),
                 band = c(TRUE, TRUE, TRUE,
                          TRUE, FALSE),
                 stringsAsFactors = FALSE)       #why do we make stringsAsFactors false here?
y
inner_join(x, y, by = "name")  #all columns of rows that match
y2 = rename(y, NAME = name)
inner_join(x, y2, by = c('name' = 'NAME'))  #when dfs have different col names, need vector to match col names in the by
left_join(x, y, by='name')  #all rows from x and only the y ones that match  #returns NA for left rows that dont have match in y
right_join(x,y,by='name')   #equivalent to a left join with the dfs flipped
full_join(x, y, by = "name")    #full join is an outer join
semi_join(x, y, by = "name")   #inner join that only keeps columns from 1st df
filter(x, name %in% y$name)   #equivalent to a semi_join, but faster
anti_join(x, y, by = "name")    #returns rows NOT in df2
filter(x, !(name %in% y$name))    #filter equiv., NOT in


bnames2 = inner_join(bnames, births, by= c('year', 'sex'))   #join datasets
View(bnames2)
bnames2 = mutate(bnames2, n = round(prop*births))  #create new column for number of births
head(bnames2)

#GOUPWISE OPERATIONS
vivian = filter(bnames2,
                name == "Vivian")
sum(vivian$n)
vivian2 = filter(bnames2, name == "Vivian",
                 year == 2008)
sum(vivian2$n)

by_color = group_by(df, color)   #groups df by color
by_color  #looks like ame df, but now it is actually a grouped_df (class(by_color)=='grouped_df')
summarise(by_color, total = sum(value))  #uses summarise on a grouped_df

by_year = group_by(bnames2, year)
summarize(by_year, total = sum(n))

group_by(bnames2, name, year)
summary = summarise(group_by(bnames2, name, year), total = sum(n))     #summarise a grouped_df
filter(summary, name == 'Vivian')
filter(summary, name == 'Vivian', year ==1895)


#now we make things easier to write using the inside out, chain operator
group_by(bnames2, name, year) #==> bnames2 %>% group_by(., name, year)
bnames2 %>% group_by(name, year)    #OR dont need the dot at all

#Can multiple chain:
bnames2 %>%                                 #original df
  group_by(name, year) %>%                #grouped df
  summarise(total=sum(n))                  #summary operation

bnames %>%
  select(-soundex) %>% 
  inner_join(births, by = c('year', 'sex')) %>%
  mutate(n = round(prop*births)) %>% 
  group_by( name, year) %>% 
  summarise(total = sum(n)) %>% 
  filter(name == 'Vivian') %>% 
  arrange(desc(total)) %>% 
  top_n(3)           #top_n(df, #) gives top # results




#Exercises

#Ex 1
filter(bnames, name =='Sean')$soundex[1]   #my Soundex is S500
filter(bnames, soundex =='S500')

filter(bnames, sex == 'girl', year == 1900 | year == 2000) 
#filter(bnames, sex=='girl' & (year ==1900|year==2000))
#???? bnames[bnames$sex == 'girl' & (bnames$year ==1900 | bnames$year == 2000)]

nrow(filter(bnames, prop > 0.01 & year > 2000))    #forgot nrow at first!!

#Ex 2
bnames_starts_with = select(bnames, starts_with('y'), starts_with('s'), starts_with('p'))
without_year = select(bnames, -year)
head(without_year)
name_year = select(bnames, contains('a'))
head(name_year)


#Ex 3
arrange(bnames, desc(prop))            #
arrange(filter(bnames, name == 'Sean'), desc(prop))[1,]    #1986
#OR filter(arrange(bnames, desc(prop)), name =='Sean')[1,]       #is one faster than another


#Ex 4
mutate(bnames, percentage = round(prop * 100, 2))  #percent rounded to 2 dec places

#Ex 5
summarise(filter(bnames, name == 'Sean'), min = min(prop), max = max(prop), mean = mean (prop))    #can allso chain this with filter > summarise

#Ex 6
bnames2 = inner_join(bnames, births, by=c("year","sex"))
head(bnames2)
bnames2 = mutate(bnames2, n = round(prop*births))
head(bnames2)

#Ex 7
head(births)
summarise(group_by(bnames2, sex, year), births = min(births))
summarise(group_by(bnames2, year, sex),
          births=first(births))

#when i used sum(n), it wasn't equiv because maybe not all names were called, when I used min(births), it worked but sex and year were out of order 
#no data from 2009 in bnames, so that was discarded when we recreated births from the innerjoined df

#Ex 8
df %>%                        #original df
  group_by(color) %>%         #grouped by color
  summarise(sum(value))       #summing values by those groups
