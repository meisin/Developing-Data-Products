library(shiny)
library(ggplot2)

dengue_dataset <- read.csv("data/dengue.csv", header=TRUE, sep=",", row.names=NULL)
dengue_dataset$Total.cases<- as.numeric(dengue_dataset$Total.cases)

shinyServer(
function(input, output){
  dataset <- reactive ({
    dengue_dataset[sample(nrow(dengue_dataset), input$sampleSize), ]
  })
  
  output$plot <- renderPlot({
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    
    print(p)
    
  }, height=700)
}
)