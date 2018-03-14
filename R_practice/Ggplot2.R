plot(iris$Sepal.Width, iris$Sepal.Length)

library(tidyr)
library(ggplot2)
?mpg
head(mpg)
View(mpg)

#SCATTERPLOTS
#relationship between engine size(displ) and highway mileage (hwy)
g = ggplot(data = mpg, aes(x = displ, y = hwy))
g + geom_point() 
g + geom_point(aes(color = class, size = class, shape = class, alpha = class))

g + geom_point(aes(color = class))   #easy to dinstinguish
g + geom_point(aes(size = class))    #size for discrete variables not great, better for continuous
g + geom_point(aes(shape = class))   #shape only should take 6 discrete values max
g + geom_point(aes(alpha = class))   #grayscale/transparency, better for continuous, because is there a link between the discrete variables?


#FACETING
fac <- g + geom_point(aes(color = displ))
fac + facet_grid(. ~ cyl)    #only facet the columns based on cylinder
fac + facet_grid(drv ~ .)    #only facet the rows base don drive (front wheel, 4 wheel, rear wheel)
fac + facet_grid(drv ~ cyl)   #facet rows by drive and cols by cyl (doesnt show too much info for our tny data set)
fac + facet_grid(~class)     #don't need the period

#GEOMS
fac + geom_smooth()     #gives scatterplot
g + geom_smooth()       #just gives function (method = auto)
fac + geom_smooth(method = lm)    #lm is a linear regression model
g + geom_smooth(se = FALSE)      #removes error bounds around line

ggplot(data = mpg, aes(x = class, y = hwy)) + 
  geom_point() + geom_boxplot(aes(color = class))          #box plots, color aes only works for class (and trans for some reason but it looks weird)
ggplot(data = mpg, aes(x = reorder(class, hwy), y = hwy)) + 
  geom_point() + geom_boxplot(aes(color = class))          #reorders the x axis "class" by the highway
ggplot(data = mpg, aes(x = reorder(class, hwy, FUN = median), y = hwy)) + 
  geom_point() + geom_boxplot(aes(color = class))         #reordered based on function median now :)

ggplot(data = mpg, aes(x = class, y = hwy)) + geom_point() + 
  geom_boxplot(fill=NA, notch=T)+ geom_jitter()

ggplot(data = mpg, aes(x = class, y = hwy)) + #geom_point() + 
  geom_dotplot(binaxis = "y", stackdir = "center")


#Diamond Dataset and BARCHARTS
class(diamonds$color)
ggplot(data=diamonds, 
       aes(x = cut)) +     #one variable given, so automatically compared to a count
  geom_bar()


ggplot(data = diamonds,aes(x =
                             cut)) + geom_bar(aes(fill =       #fill is so much better!!
                                                    cut))

ggplot(data = diamonds, aes(x =
                              cut)) + geom_bar(aes(color =        #color just does a background
                                                     cut))

ggplot(data = diamonds, aes(x = color)) +
  geom_bar(aes(fill = cut))        #raw count
ggplot(data = diamonds, aes(x = color)) +
  geom_bar(aes(fill = cut),
           position = "fill")      #fills graph of each bar so can see PROPORTIONS
ggplot(data=diamonds, aes(x = color)) +
  geom_bar(aes(fill=cut), position = 'dodge')    #barchart within barchart


ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point(position = 'jitter') #gives little random noise to each point to look more like scatter plot
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point() + geom_jitter(height = 0)   #with height = 0, it just spreads
?geom_jitter

ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point(aes(color = class)) + geom_jitter(height = 0, aes(color = class))   #with height = 0, it just spreads



#HISTOGRAMS
g <- ggplot(data = diamonds, aes(x = carat))
g + geom_histogram(binwidth = 1)
g + geom_histogram(binwidth = .1)   #decresinign bin width
g + geom_histogram(binwidth = .01)  #even smaller and see a pattern --> rounding in data, localized to 1, 1.25, 1.5, 1.75
g + geom_histogram()    #default is range/30

ggplot(data = diamonds, aes(x = depth)) +
  geom_histogram(binwidth = .2) +
  coord_cartesian(xlim=c(55,70))    #xlim gives window, so look at data beforehand
zoom = coord_cartesian(xlim=c(55,70))      #no good default xlim, so should set
ggplot(data = diamonds, aes(x = depth)) +
  geom_histogram(binwidth = .2) + zoom    #named it zoom because its like zoom on a calculator

ggplot(data=diamonds, aes(x =depth))+ geom_histogram(aes(fill = cut), binwidth=.5) + zoom


#COMPARING VARIABLES
g <- ggplot( data = diamonds, aes(x = depth))
zoom <- coord_cartesian(xlim = c(55, 70))
g + geom_histogram(binwidth = 0.2, aes(fill=cut)) + facet_wrap( ~ cut) + zoom

g + geom_histogram(binwidth = 0.2) + geom_freqpoly(binwidth=0.2, aes(color = cut)) + facet_wrap( ~ cut) + zoom

g + geom_freqpoly(binwidth=0.2, aes(color = cut)) +       #no histogram, just smooth line
  facet_wrap( ~ cut) + zoom

g + geom_freqpoly(aes(color = cut), binwidth = 0.2) + zoom   #all sam egraph, no facet!
g + geom_density(aes(color = cut)) + zoom     #shows proportions rather than absolute size

#histogram of price faceted by cut
ggplot(data = diamonds, aes(x = price)) +
  geom_histogram(binwidth = 500) + facet_wrap(~ cut)     #separated graphs
ggplot(data = diamonds, aes(x = price)) +               #single graph
  geom_histogram(aes(fill = cut))



ggplot(data = diamonds, aes(x = price)) +       #the area under each curve is equivalent so may be easier to compare, why do fair diamonds cost more?
  geom_density(aes(color = cut))

#VIS BIG DATA
g <- ggplot(data = diamonds, aes(x = carat, y = price))
g + geom_point(aes(color = cut), position = 'jitter')       #shows scatter plot, but so many observations its hard to tell where most lie, especially since an overwhelming amount is ideal cut

g + geom_bin2d()     #pixelated 2d bins colored by count
g + geom_density2d()    #contour lines to show density concentrations
g + geom_point() + geom_density2d()    #combined with scatter plot
g + geom_smooth(aes(group = cut, color = cut), se=F)    #make sure to color and group
g + geom_point(size = .1, alpha = 0.2)   #can adjust size an transparency of each point to see more patterns



#SAVING GRAPHS
#screenshot
#or code
ggsave("my-plot.pdf")    #pdf higher quality than png, takes longer
ggsave("my-plot.png")
ggsave("my-plot.pdf", width = 6, height = 6)
ggsave("my-plot.png", width = 6, height = 6)




#CUSTOMIZING GRAPHS

#Texas population data plot
texas = read.csv('texas.csv')
head(texas)
g = ggplot(data = texas, aes(x = long, y = lat))    #plots longitude and latitude (vertices of counties)
g + geom_point()
View(texas)

#plot map of counties because vertices are ordered to connect the dots
g + geom_polygon(aes(group = group, fill = county), 
                 show.legend = F)     #legend would be too large for all the counties

#if unordered 
texas2 = texas[sample(nrow(texas)), ] #Row order matters!
ggplot(data = texas2, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group))


library(maps)
counties = map_data( "county" ) # Using the built-in USA county
# map dataset.
ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = group))     #fill county by group number, which is arbitrary based on alphabetical state order, messed up spots because extra data points added in late
View(counties)
ggplot(data = counties, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = region), show.legend = F)

ggplot(data = texas, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = bin, na.rm = T))   #how to remove NA??? 

ggplot(data = texas, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = pop))     #not helpful because the incredible high pops of houston/dallas make the colors skewed, log bins are better


#COORDINATE SYSTEMS
g <- ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point()
g$coordinates
g2 = g + coord_polar()
g2$coordinates
g2

#can groph a pie chart with polar
coord_polar()
coord_flip()
coord_fixed(ratio = 1/10000)
coord_trans(y ='log')   #OR coord_trans(x ='log', y = 'log')
coord_cartesian(xlim = c( 0,1 ), ylim = c( 0 , 5000 ))
coord_map()      #mercator projection
cc + coord_polar(theta = "y" )   #pie chart


#more options for customizing in slides for Week 2
