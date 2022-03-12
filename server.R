
# reading model 
model <- readRDS("model.rds")

server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    temp <- data.frame(speed=input$speed,hd=input$hd,ram=input$ram,
                       screen=input$screen,cd=input$cd,multi=input$multi,premium=input$premium,
                       ads=input$ads,trend=input$trend)
    
    #test$outlook <- factor(test$outlook, levels = c("overcast", "rainy", "sunny"))
    temp$cd <- factor(temp$cd, levels = c("yes","no"))
    temp$multi <- factor(temp$multi, levels = c("yes","no"))
    temp$premium <- factor(temp$premium, levels = c("yes","no"))
    
    Output <- predict(model,temp)
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("You Can expect around this price for given Specifications")
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderText({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

