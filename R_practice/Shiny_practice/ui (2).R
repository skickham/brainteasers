library(shiny)

fluidPage(
  titlePanel("NYC Flights 2014"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "origin",
                     label = "Departure airport",
                     choices = unique(flights[, origin])),
      selectizeInput(inputId = "dest",
                     label = "Arrival airport",
                     choices = unique(flights[, dest])),
      selectizeInput(inputId = "mon", 
                     label = "Month", 
                     choices = month.name[unique(flights[, month])])
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Graph", 
                 icon = icon("bar-chart-o"),
                 fluidRow(
                   column(6, plotOutput("count")),
                   column(6, plotOutput("delay"))
                 )), 
        tabPanel("Data",
                 icon = icon("database"),
                 tableOutput("data"))
      )
      
      
    )
  )
)
