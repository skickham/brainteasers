##ui.R##
library(shinydashboard)
library(shiny)

shinyUI(dashboardPage(
  dashboardHeader(title = 'My Dashboard'),
  dashboardSidebar(
    sidebarUserPanel('Sean Kickham',
                     image = 'https://s3-us-west-1.amazonaws.com/powr/defaults/image-slider2.jpg'),
    sidebarMenu(
      menuItem('Map', tabName = 'map', icon = icon('map')),
      menuItem('Data', tabName = 'data', icon = icon('database'))),
    
    selectizeInput('selected',
                   'Select Item to Display',
                   choice)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = 'map',
              fluidRow(infoBoxOutput('maxBox'),
                       infoBoxOutput('minBox'),
                       infoBoxOutput('avgBox')),
              fluidRow(box(htmlOutput('map'),
                           height = 300),
                       box(htmlOutput('hist'),
                           height = 300))),
      tabItem(tabName = 'data',
              fluidRow(box(DT::dataTableOutput('table'),
                           width = 12)))
    )
  )
))


#?icon to find list of icons @ For lists of available icons, see http://fontawesome.io/icons/ and http://getbootstrap.com/components/#glyphicons.

