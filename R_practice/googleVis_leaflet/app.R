library(shiny)
library(googleVis)
library(leaflet)
library(dplyr)
library(maps)


ui = fluidPage(
  leafletOutput('mymap'),
  br(),       #break
  checkboxInput('show', 'Show States', value = FALSE)
)


colStates = map("state", fill = TRUE,
                plot = FALSE,
                region = c('florida', 'louisiana', 
                           'mississippi', 'alabama', 
                           'georgia', 'tennesse'))



server = function(input, output, session) {
  output$mymap <- renderLeaflet({
    leaflet(Andrew) %>%
      addProviderTiles("Esri.WorldStreetMap") %>% 
      addPolylines(~Long, ~Lat)
  }) 
  
  #render the base layer(s) of the map first so the reactive expression 
  
  observeEvent(input$show, {
    proxy = leafletProxy('mymap')
    if(input$show) {
      proxy %>% addPolygons(data = colStates, stroke = F,
                            fillColor = heat.colors(6, alpha = NULL),
                            layerId = LETTERS[1:6])
    } else {
      proxy %>%  removeShape(layerId = LETTERS[1:6])
    }
  })
}

shinyApp(ui, server)
