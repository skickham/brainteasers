library(shiny)
library(data.table)

fluidPage(
  titlePanel('Old Faithful Geyser Data'),
  sidebarLayout(
    sidebarPanel(
      #img(src="https://upload.wikimedia.org/wikipedia/commons/1/1b/Old_Faithfull-pdPhoto.jpg", 
      #      width="100%"),
      
      sliderInput("bins", "Number of bins:",
                  min = 1, max = 50, value = 30),
      
      selectizeInput("col", "Columns in Plot", 
                     choices = colnames(faithful),
                     selected = colnames(faithful)[1]),
      
      selectizeInput("bincolor", "Color for Bins", 
                     choices = c('blue', 'red', 'forestgreen', 'yellow', 'orange', 'purple'),
                     selected = 'red'),
      
      selectizeInput(inputId = "mon", 
                     label = "Month", 
                     choices = month.name[unique(flights[, month])]),
      
      textInput('scatterTitle', label = "Scatter Plot Title", value = 'Make your own')
  
    ),
    mainPanel(
      tabsetPanel(
        tabPanel(#tags$iframe(src="https://www.youtube.com/embed/wE8NDuzt8eg", 
      #        width="480", height="270", frameborder = '1')
          textOutput('texty'),
          plotOutput("distPlot")),
      tabPanel(
        plotOutput('distPlot_2'))
      )
    )
  )
)
