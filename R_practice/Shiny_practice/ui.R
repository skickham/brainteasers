library(shiny)
library(data.table)


fluidPage(
  titlePanel("NYC Flights 2014"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput(inputId = "origin",
                     label = "Departure airport",
                     choices = unique(flights[, origin]),
                     selected = 'LGA'),
      selectizeInput(inputId = "dest",
                     label = "Arrival airport",
                     choices = sort(unique(flights[, dest])))
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("count")),
        column(6, plotOutput("delay"))
      )
    )
  )
)
