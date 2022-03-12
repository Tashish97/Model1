library(shiny)
library(shinythemes)

####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
                navbarPage(
                  # Page header
                  'Computer Price Estimator',
                  
                  # Input values
                  sidebarPanel(
                    HTML("<h3>Choose Your PC Specifications:</h3>"),
                    
                    
                    selectInput("speed", label = "Speed:", 
                                choices = list("25" = 25, "33" = 33, "50" = 50,"66" = 66, "75" = 75, "100" = 100), 
                                selected = 33),
                    
                    sliderInput("hd", "Hard Disk:",
                                min = 80, max = 2100,
                                value = 528),
                    
                    selectInput("ram", label = "RAM:", 
                                choices = list("2" = 2, "4" = 4, "8" = 8,"16" = 16, "24" = 24, "32" = 32), 
                                selected = 4),
                    
                    selectInput("screen", label = "Screen:", 
                                choices = list("14" = 14, "15" = 15, "17" = 17), 
                                selected = 14),
                    
                    selectInput("cd", label = "Cd Drive:", 
                                choices = list("Yes"="yes", "No" = "no"), 
                                selected = "no"),
                    
                    selectInput("multi", label = "Multicore:", 
                                choices = list("Yes"="yes", "No" = "no"), 
                                selected = "no"),
                    
                    selectInput("premium", label = "Premium Segment:", 
                                choices = list("Yes"="yes", "No" = "no"), 
                                selected = "yes"),
                    
                    sliderInput("ads", "ADS:",
                                min = 29, max = 340,
                                value = 339),
                    
                    sliderInput("trend", "Trend:",
                                min = 1, max = 35,
                                value = 17),
                    
                    actionButton("submitbutton", "Submit", class = "btn btn-primary")
                  ),
                  
                  mainPanel(
                    tags$label(h3('Status/Output')), # Status/Output Text Box
                    verbatimTextOutput('contents'),
                    tableOutput('tabledata')
                    
                  )
                )#navbarpage
)