library(dplyr)
#Question 1
#a
library(ggplot2)
data(mpg)
View(mpg)  #head(mpg,5)
?mpg


#b
select(mpg, V1 = year, V2 = cyl, V3 = cty, V4 = hwy)

#c
summarise(group_by(mpg, cyl), city_mile_per_gallon = mean(cty), highway_miles_per_gallon = mean(hwy))

#d
summarise(group_by(mpg, manufacturer), max(cty))    #my way doesn't give model car column

tbl_df(mpg) %>%
  group_by(manufacturer) %>%
  top_n(1,cty) 





#Question 2
#1
mpg = mutate(mpg, ratioHVE = hwy/displ)

tbl_df(mpg) %>%                  #tbl_df makes it tabular so it runs faster
  mutate(ratioHVE = hwy/displ)


#2
mpg = mutate(mpg, rationCVE = cty/displ) 
mpg

#3
summarise(group_by(mpg, year, manufacturer), mean(ratioHVE), mean(rationCVE))

tbl_df(mpg) %>% 
  group_by(year, manufacturer) %>% 
  summarise(mean(ratioHVE), mean(rationCVE))


#4
summarise(group_by(mpg, year, drv), max(ratioHVE))







#Question 3
#1
NYC_Jobs <- read.csv("C:/Users/skick/Desktop/NYC Data Science Academy/Class_R/NYC_Jobs.csv", stringsAsFactors = F)
View(NYC_Jobs)
str(NYC_Jobs)

NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Hourly', ] = mutate(NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Hourly', ],     
                                                           Salary.Range.From = Salary.Range.From *40 * 52)
NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Hourly', ] = mutate(NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Hourly', ], 
                                                           Salary.Range.To = Salary.Range.To *40 * 52)
NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Daily', ]= mutate(NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Daily', ], 
                                                         Salary.Range.From = Salary.Range.From *5 * 52)
NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Daily', ] = mutate(NYC_Jobs[NYC_Jobs$Salary.Frequency == 'Daily', ], 
                                                          Salary.Range.To = Salary.Range.To *5 * 52)


View(NYC_Jobs)
by_agency = group_by(NYC_Jobs, Agency)
class(by_agency)
salaries_by_agency = summarise(by_agency, 
                               Mean_Low = mean(Salary.Range.From), 
                               Mean_High = mean(Salary.Range.To), 
                               Median_Low = median(Salary.Range.From),
                               Median_High = median(Salary.Range.To))

#2
filter(salaries_by_agency, 
       Mean_Low == max(salaries_by_agency$Mean_Low)) %>% 
  select(Agency)

#3
NYC_Jobs %>% 
  transmute(Posting.Type = Posting.Type, 
            Range = Salary.Range.To - Salary.Range.From) %>% 
  group_by(Posting.Type) %>% 
  summarise(Average_Range = mean(Range))
#No,the average range is similar between the two (25000 and 24000)

#4
NYC_Jobs %>% 
  group_by(Level) %>% 
  summarise(Average_Range = mean(Salary.Range.To - Salary.Range.From))


#5
NYC_Jobs %>% 
  mutate(Range = X..Of.Positions * 
           (Salary.Range.To - Salary.Range.From)) %>% 
  group_by(Agency) %>% 
  summarise(avg_expenses = sum(Range))    #changed from mean to sum

View(NYC_Jobs)


#6
NYC_Jobs %>% 
  mutate(Range = Salary.Range.To - Salary.Range.From) %>% 
  filter(Range == max(Range)) %>% 
  select(Civil.Service.Title)
