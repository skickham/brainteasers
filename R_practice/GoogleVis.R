library(googleVis)

#M <- gvisMotionChart((Fruits, "Fruit", "Year",
#                      options = list(width = 600, height = 400))
#plot(M)                     

#demo(googleVis)

head(mtcars)

scatter = gvisScatterChart(mtcars[,c('wt', 'mpg')])
plot(scatter)

print(scatter)  #HTML output  #need internet for googleVis

dt <- mtcars[,c('wt','mpg')]
dt$cyl_4 = ifelse(mtcars$cyl ==4, dt$mpg, NA)
dt$cyl_4.html.tooltip = rownames(dt)
dt$cyl_6 = ifelse(mtcars$cyl ==6, dt$mpg, NA)     #making three columns to get three colored groups in chart
dt$cyl_6.html.tooltip = rownames(dt)
dt$cyl_8 = ifelse(mtcars$cyl ==8, dt$mpg, NA)     #called on mtcars where where cyl col still exists
dt$cyl_8.html.tooltip = rownames(dt)
dt$mpg = NULL    #delete mpg since we moved it
head(dt)





scatter <- gvisScatterChart(dt)    #automatically assumes different values
plot(scatter)

my_options = list(width = '600px', height = '300px',
                  title = 'Motor Trend Car Road Tests',
                  hAxis = "{title: 'Weight (1000 lbs)'}",
                  vAxis = "{title: 'Miles/(US) gallon'}")   #this is a JSON format
plot(gvisScatterChart(dt, options =my_options))


#some coding is in java
#Explorer actions 
#careful! case sensitive!

my_options$explorer = "{actions:['dragToZoom','rightClickToReset']}" #just put Java code in double quotes 
plot(gvisScatterChart(dt, options = my_options))


#set tooltips to allow a text bubble to pop up for each point with the info you want
#need to set each tooltip in the column immeditely following the column it refers to!!!!


head(dt)
plot(gvisScatterChart(dt, options = my_options))



#LEAFLET
library(leaflet)
library(dplyr)
leaflet() %>%  addTiles() %>%   #add default OpenStreetMap map
  addMarkers(lng = -74.0059, lat = 40.7128, popup = "New York City")

#leaflet just adds more layers like ggplot
leaflet_andrew = leaflet(Andrew) %>% 
  addTiles() %>% 
  addPolylines(~Long, ~Lat)
leaflet_andrew

library(maps)
colStates = map("state", fill = TRUE,
                plot = FALSE,
                region = c('florida', 'louisiana', 
                           'mississippi', 'alabama', 
                           'georgia', 'tennesse'))

 #for heat.colors

leaflet_andrew = leaflet_andrew %>% 
  addPolygons(data = colStates,
              fillColor = heat.colors(6, alpha = NULL),   #alpha = NULL because the transparency of his particular function has a glitch
              stroke = FALSE)      #it was still dark once I fixed it, but that's b/c it layered on the colors on top of the old gray since this just continued to reassign
leaflet_andrew

#CHanging Tiles
leaflet_andrew = leaflet_andrew %>% 
  addProviderTiles("Esri.WorldStreetMap")
leaflet_andrew
