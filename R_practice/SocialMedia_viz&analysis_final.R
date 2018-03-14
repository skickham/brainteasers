
# The data science team at a social media company ran a test to 
# change the way they presented a feed of posts to their users.
# They randomly assign the visitors into different test cohorts 
# (A-F), each cohort represents a different way to fetch a feed.
# The question now is: how has the test performed?
 


# load libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(anytime)



###################################
### Cleaning Data #################
###################################



# load datasets
users = fread('./users.csv', header = FALSE)
events = fread('./events.csv', header = FALSE)


# add column names
colnames(users) = c('user_id', 'device', 'user_created')
colnames(events) = c('test_cohort', 'event_name', 'user_id', 'post_id', 'post_type', 'post_created')


# EDA users
dim(users)  # 82,000 users
sapply(users, class)    # all character types
str(users)   
summary(users)
head(users)
unique(users$device)   # many versions of android and ios


# EDA events
dim(events)   # 1.7 million observations
sapply(events, class)   # all character types
str(events)   
summary(events)
head(events)
unique(events$test_cohort)   # A - F (six)
unique(events$event_name)    # 'Whisper created', 'Heart', 'Conversation created'
unique(events$post_type)     # 'reply', 'top-level', 'undefined'


# convert unix epoch times to datetimes
users$user_created = as.numeric(users$user_created)
users$user_created = users$user_created/1000000
users$user_created = with(users, anytime(user_created))

events$post_created = as.numeric(events$post_created)
events$post_created = events$post_created/1000
events$post_created = with(events, anytime(post_created))


# check complete cases
sum(!complete.cases(users))   # 21 dates missing 
sum(!complete.cases(events))


# merge the data frames
both = full_join(users, events, by = 'user_id')
sum(!complete.cases(both))  # 28,926 incomplete cases
nrow(both)   # 1.7 million, but still some more than before (user ids that dont match perhaps)


###################################
### Visualizing Data ##############
###################################
both %>%  
  group_by(user_id) 

# examine post_types
ggplot(data = events, aes(x = post_type)) + geom_bar(aes(fill = post_type))
ggplot(data = both, aes(x = post_type)) + geom_bar(aes(fill = post_type))   
# most undefined, then reply, the top-level


# examine event_names
ggplot(data = events, aes(x = event_name)) + geom_bar(aes(fill = event_name))  
# event names pretty evenly spread, conversation most common, heart least


# examine test_cohorts
ggplot(data = events, aes(x = test_cohort)) + geom_bar(aes(fill = test_cohort))  
# events evenly spread among cohorts


# how many users in each cohort?
users_by_cohort = both %>% group_by(test_cohort) %>% summarise(Number = length(unique(user_id)))
# cohorts have between 8690 users and 9003 users
sum(users_by_cohort$Number)   # matches 82,000 users
events_by_cohort = both %>% group_by(test_cohort) %>% summarise(Number = length(post_created))
cohorts = full_join(users_by_cohort, events_by_cohort, by = 'test_cohort')
colnames(cohorts) = c('cohort', 'users', 'events')
cohorts = cohorts %>% mutate(event_rate = events/users)
cohorts = cohorts[-7,]

ggplot(cohorts, aes(x = cohort, y = event_rate)) + 
  geom_bar(stat = 'identity', aes(fill = cohort))


#the event per user rates seem pretty consistent across the cohorts
# maybe there is a difference in the post_type across cohorts
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = post_type))
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = post_type), position = 'fill')
#doesnt look like it but maybe in event_name
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = event_name))
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = event_name), position = 'fill')
# again looks pretty similar
# by device
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = device))
ggplot(both, aes(x = test_cohort)) + 
  geom_bar(aes(fill = device), position = 'fill')
# again, does not look significant in any way across groups

# Explore Time Series
ggplot(both, aes(Date, Views)) + geom_line() +
  scale_x_date(format = "%b-%Y") + xlab("") + ylab("Daily Views")

both$date = format(both$post_created, '%m/%d/%y')
both$month = format(both$post_created, '%m')
str(both)
#



######################################
###### Hypothesis Testing ############
######################################

# Chi-Square Tests for Independence 

# Between Cohort and Event_Name
chisq.test(table(events$test_cohort, events$event_name))
# makes the freq table: table(events$test_cohort, events$event_name)
# Between Cohort and Post_type


# Between Event_name and Post_type within a cohort

chisq.test()



# You might follow the steps below:
# - Basic stats with visualization
# - Hypothesis testing
# 
# Please include analysis, code and conclusion 
# in a rmarkdown report and submit it to Github 
# (https://github.com/casunlight/bootcamp009_homework/tree/master/05-12MidTermAssessment).

