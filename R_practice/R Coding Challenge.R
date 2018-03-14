library(dplyr)
shares = as.data.frame(cbind(
  FacebookID = c(17998,29830,30980,23089,8888,29372),
  action_ID = c(1001,981,734,985,332,125),
  type = c('Post','Comment','Photo','Share', 'Comment', 'Comment'),
  referred_ID = c(345,1001,234,1001,1001,985)))

comments = shares %>% filter(type == "Comment") %>% transmute(ID = referred_ID, Comment = type)
posts = shares %>% filter(type != "Comment") %>% transmute(ID = action_ID, type = type)

join = full_join(posts, comments, by="ID") 
count = join %>% group_by(ID) %>%  summarise(comments = n())
count %>%  group_by(comments) %>% summarise('# of stories' = n())





library(dplyr)
shares = as.data.frame(cbind(
  FacebookID = c(17998,29830,30980,23089),
  action_ID = c(1001,981,734,985),
  type = c('Post','Comment','Photo','Share'),
  referred_ID = c(345,1001,234,1001)))


comments = shares %>%
  filter(type == "Comment") %>% 
  transmute(ID = referred_ID, Comment = 1)


posts = shares %>% 
  filter(type != "Comment") %>% 
  transmute(ID = action_ID, type = type)


join = full_join(posts, comments, by='ID') 

count = join %>% 
  group_by(ID) %>%  
  summarise(comments = sum(Comment))


answer = count %>% 
  group_by("# of comments" = comments) %>%
  summarise('# of stories' = n())



