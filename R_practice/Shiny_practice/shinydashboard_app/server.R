library(shiny)
library(shinydashboard)
library(DT)
library(googleVis)

shinyServer(function(input, output) {
  
  output$map = renderGvis({
    gvisGeoChart(state_stat, 'state.name', input$selected,
                 options = list(region = 'US', displayMode = 'region',
                                resolution = 'provinces',
                                width = 'auto', height = 'auto'))
    })
  
  output$hist = renderGvis(
    gvisHistogram(state_stat[,input$selected, drop = F]))
  
  output$table = DT::renderDataTable({
    datatable(state_stat, rownames = F) %>% 
      formatStyle(input$selected,
                  background = 'skyblue', fontWeight = 'bold')
    
  })
  
  
  output$maxBox = renderInfoBox({
    max_value = max(state_stat[,input$selected])
    max_state = state_stat$state.name[state_stat[,input$selected]==max_value]
    infoBox(max_state, max_value, icon = icon('hand-o-up'))
  })
  
  output$minBox = renderInfoBox({
    min_value = min(state_stat[,input$selected])
    min_state = state_stat$state.name[state_stat[,input$selected]==min_value]
    infoBox(min_state, min_value, icon = icon('hand-o-down'))
  })
  
  output$avgBox = renderInfoBox(
    infoBox(paste("AVG.", input$selected),
            mean(state_stat[,input$selected]),
            icon = icon('calculator'), fill = T))
})