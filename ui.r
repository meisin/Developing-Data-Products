library(shiny)
library(ggplot2)

#dataset <- diamonds
dataset <- read.csv("data/dengue.csv", header=TRUE, sep=",", row.names=NULL)

fluidPage(
  titlePanel("Dengue Data in Malaysia"),
  
  sidebarPanel(
    sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset), 
                value=min(1000, nrow(dataset)), step=500, round=0),
    
    selectInput('x', 'X', names(dataset)),
    selectInput('y', 'Y', names(dataset), names(dataset)[[3]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter', TRUE),
    
    selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))), 
    selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
    
  ),
  
  mainPanel(
    p("This is an interactive graph that provides a snapshot view of Dengue condition in Malaysia from "),
strong("2012 to 2015."),
    p("The available parameters are :"),
    code("Year, Week, State, Total Cases, Period of Outbreak"),
    plotOutput('plot'))
)
