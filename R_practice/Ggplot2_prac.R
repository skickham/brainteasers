setwd(dir = '/Users/skick/Desktop/NYC Data Science Academy/Class_R/')
library(dplyr)
library(ggplot2)

#Question 1
#1
Champions = read.csv('Champions.csv', stringsAsFactors = FALSE)
#View(Champions)
tbl_df = filter(Champions, HomeGoal > AwayGoal)
filter(Champions, HomeTeam == 'Barcelona' | HomeTeam == 'Real Madrid')


#2
Home = select(Champions, starts_with('Home'))
Smaller = select(Champions, 
                 contains('Team'), 
                 contains('Goal'), 
                 contains('Corner'))

head(Home)
head(Smaller)


#3
arrange(Smaller, desc(HomeGoal))


#4
by_hometeam = group_by(Champions, HomeTeam)
summarise(by_hometeam, 
          Avg_goal = mean(HomeGoal), 
          Avg_poss = mean(HomePossession),
          Avg_yellow = mean(HomeYellow))


#5
#optional
temp = mutate(CL, score = ifelse(HomeGoal > AwayGoal,
                                 paste(HomeGoal, AwayGoal, sep = "-"),
                                 paste(AwayGoal, HomeGoal, sep = "-")))
temp = group_by(temp, score)
temp = arrange(summarise(temp, n = sum(n)), desc(n))
temp[1:5, ]


## Another solution using apply
cl_sub2=select(CL,contains("Goal"))
# Nice solution by transpose the matrix.
all_score<-t(apply(cl_sub2,1,sort))
all<-data.frame(score=apply(all_score,1,paste,collapse=""))

score_frq<-all %>%
  group_by(.,score)%>%
  summarise(.,count=n()) %>%
  arrange(.,desc(count))

score_frq[1:5,]

##### SE version of dplyr 
##### https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html





#Question 2
#1
data(cars)
p = ggplot(data = cars, aes(x = speed, y = dist)) + 
  geom_point()


#2
p + 
  ggtitle('Speed Vs. Distance') +
  labs(x = 'Speed (mpg)', y = 'Stopping Distance (ft)')


#3
ggplot(data = cars, aes(x = speed, y = dist)) + 
  geom_point(pch = 17, col = 'red')



#Question 3
data(faithful)
#View(faithful)

#1
faithful$length = ifelse(faithful$eruptions < 3.2, 'short', 'long')
faithful$length = as.factor(faithful$length)

#2
ggplot(data = faithful, aes(x = length, y = waiting)) + geom_boxplot(aes(color = length))

#3
ggplot(data= faithful, aes(x = waiting)) + geom_density(aes(color = length))

#4
#From the density curves, it seems the waiting times for the long eruptions are around 80 minutes, 
#and the times for the short eruptions is around 54 minutes.
#From the box plots, you can see the same thing within the common values.


#Question 4
knicks = load('Knicks.RDA')     #saves the table under "data" for some reason ??????
knicks = data     #reassign the data frame to "knicks"
#View(knicks)

#1
Winratio_byseason = knicks %>% 
  group_by(season) %>% 
  summarise(winning_ratio = sum(win == 'W')/n())

#could use spread to split the win into two columns then just count the columns that have it

ggplot(Winratio_byseason, aes(x = season, y = winning_ratio)) + 
  geom_bar(stat = 'identity', aes(fill = season))      #doesn't work unless use stat = 'identity'



#2
Winratio_byhome = knicks %>% 
  group_by(season, visiting) %>% 
  mutate(winning_ratio = sum(win == 'W')/n())     #can use summarise instead of mutate

ggplot(Winratio_byhome, 
       aes(x = season, y = winning_ratio)) + 
  geom_bar(aes(fill = visiting), 
           position = 'dodge', 
           stat = 'identity')



#3
ggplot(knicks, aes(x = points)) +
  geom_histogram(binwidth = 5, 
                 aes(fill = season)) + 
  facet_wrap(~season)


#4
#optional
knicks3 <- group_by(knicks, opponent) %>%
  summarise(ratio=sum(win=="W")/n(), diff=mean(points-opp))

ggplot(knicks3,aes(x=diff, y=ratio)) +
  geom_point(color='red4',size=4)+
  geom_hline(yintercept=0.5,colour='grey20',size=0.5,linetype=2)+    #at 0.5 for winning/losing percentage
  geom_vline(xintercept=0,colour='grey20',size=0.5,linetype=2)+     #at 0 for winning/losing point diff   #could put at mean
  geom_text(aes(label=substring(opponent,1,5)),
            hjust=0.7, vjust=1.4,angle = -35)+
  theme_bw()

