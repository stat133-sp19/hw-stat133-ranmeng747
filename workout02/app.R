#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

source('functions.R')


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving simulations"),
   
   # Input panel with 3 columns 
   fluidRow(
      inputPanel( style = "background-color: white",
         
         column(12,
         sliderInput("initial",
                     "Initial Amount:",
                     min = 0,
                     max = 100000,
                     value = 1000, 
                     step = 500),
         
         sliderInput("contrib",
                     "Annual Contribution:",
                     min = 0,
                     max = 50000,
                     value = 2000, 
                     step = 500)
       
         ),
        
         column(12,
         sliderInput("return",
                     "Return Rate (in %):",
                     min = 0,
                     max = 20,
                     value = 5, 
                     step = 0.1),
        
        sliderInput("growth",
                    "Growth Rate(in %):",
                    min = 0,
                    max = 20,
                    value = 2, 
                    step = 0.1)
       
         ),
        
         column(12,
         sliderInput("year",
                     "Years:",
                     min = 0,
                     max = 50,
                     value = 20, 
                     step = 1),
         
        
        selectInput('facet', 'Facet?', choices = list('No' = 'No', 
                                                      'Yes' = 'Yes')) 
        
         )
        
      ),
      
      # Show a plot of the generated distribution
      mainPanel( 
         strong("Timelines"),
         plotOutput("Timelines"),
         
         strong('Balances'),
         #tableOutput('Balances'), 
         verbatimTextOutput('Balances'),
         
         width = 12
      
      )
      
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  dat <- reactive({
    year = c(0: input$year)
    no_contrib = rep(0, length(year))
    fixed_contrib = rep(0, length(year))
    growth_contrib = rep(0, length(year))
    
    for (i in year){
      no_contrib[i+1] <- future_value(amount = input$initial, rate = input$return/100, years = i)
      fixed_contrib[i+1] <- no_contrib[i+1] + annuity(contrib = input$contrib, rate = input$return/100, years = i)
      growth_contrib[i+1] <- no_contrib[i+1] + growing_annuity(contrib = input$contrib, 
                                                               rate = input$return/100, 
                                                               growth = input$growth/100, years = i)
    }
    
    dat <- data.frame(year = year, no_contrib = no_contrib, 
                      fixed_contrib = fixed_contrib, growing_contrib = growth_contrib)
    rownames(dat) <- 1:nrow(dat)
    
    return (dat)
  })
  
  
   output$Timelines <- renderPlot({
     dat_melted <- reshape2::melt(dat(), id.var='year')
     colnames(dat_melted) <- c('Year', 'variable', 'value')
     
     gg<- ggplot(dat_melted, aes(x = Year, y = value, col = variable)) +
      geom_line(size = 1.2) + xlab('Year') + ylab('value') + 
       ggtitle('Three modes of investing') + 
       scale_y_continuous(expand = c(0, 0), limit = c(0, max(dat_melted$value)+ 1200)) + 
       geom_point(size = 2.5) 
     
     if (input$facet == 'No'){
       return (gg)
     }
     
     else if(input$facet == 'Yes'){
       return (gg + facet_wrap(~ variable) +
                 theme_bw() + 
                 geom_ribbon(aes(ymin = 0, ymax = value, fill = variable), alpha = 0.4))
     }
      
   })
   
  # output$Balances <- renderTable({
     #dat()
  # }, rownames = TRUE,
   #digits = 3)
   
  output$Balances <- renderPrint({
   dat()
  })
   
   
}

# Run the application 
shinyApp(ui = ui, server = server)

