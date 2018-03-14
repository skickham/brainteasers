library(shiny)

function(input, output) {
  
  output$texty = renderText(
    'sample text'
  )
  
  output$distPlot = renderPlot({
    x = faithful[,2]
    bins = input$bins
    plot(faithful$eruptions, faithful$waiting, main=input$scatterTitle, type = 'p',  
         xlab="Eruption Time", ylab="Waiting Time ", pch=9, col = input$bincolor)
    })
    
  output$distPlot_2 = renderPlot({
    x = faithful[,input$col]
    bins = input$bins
    hist(x, breaks = bins,
         col = input$bincolor,
         border = 'gold')
    
    })
}