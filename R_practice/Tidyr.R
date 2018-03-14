library(tidyr)

table1
table2
spread(table2, key = type, value = count)
table4a
gather(table4a, key = 'year', value = 'case', 2:3)


#separate a single column into two cols: basic R
temp <-
  data.frame(t(matrix(unlist(strsplit(table3$rate,split='/')),
                      ncol=length(table3$rate), nrow = 2)))
table3_new <- cbind(table3[,-3], temp)
colnames(table3_new)[3:4] <- c("case","population")
#tidyr
separate(table3, rate, into = c('cases', 'population'), sep = '/')
separate(table3, rate, into = c('cases', 'population'))


table5
unite(table5, 'new', century, year, sep ='')
unite(table5, 'new', century, year, sep ='', remove = F) #units new col and still keeps old (not too useful)


#PRACTICE
cpi = read.csv('urban_cpi.csv', stringsAsFactors = F)
View(cpi)
cpi = gather(cpi, key = 'timeframe', value = 'cpi', 2:15) #or use -1 instead of 2:15
View(cpi)
#OR
cpi2 = read.csv('urban_cpi.csv', stringsAsFactors = F) %>% 
  gather(key = 'month', value = 'cpi', -1) %>% 
  arrange(Year)

cpi2$cpi = as.character(cpi2$cpi)  
cpi2
separate(cpi2, cpi, into = c('Whole', 'decimal'), sep = '\\.')  #if put in sep = '.' it doesn't work for some reason, so need to escape the dot with two backslashes or not put it in at all and tidyr will find it

