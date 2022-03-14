#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

function(input, output) {
  
  selectedData <- reactive({
    state_df <- df %>% filter( ICD.Chapter == input$icd, State == input$state) 
    nation_df <- nation_avg_df %>% filter( ICD.Chapter == input$icd)
    selected <- as.data.frame(bind_rows(state_df, nation_df))
  })
  
  output$plot1 <- renderPlotly({
    
    ggplotly(ggplot(selectedData(), aes(Year,Crude.Rate,color=State)) + 
            geom_point() +
            geom_smooth(data=selectedData(), aes(Year,Crude.Rate,color=State),method=lm,se=FALSE) +
            labs(x = "Year", y = "Crude Rate") + labs(fill="") + theme(legend.title = element_blank()) + 
            ggtitle(sprintf("Scatterplot - %s vs. National Average", input$state )) + 
            scale_x_continuous(breaks = seq(1999, 2010, 2), limits = c(1999, 2010)) 
    )
  })
  
  output$plot2 <- renderPlotly({
    nation_slope <-  filter(nation_model, ICD.Chapter == input$icd) %>% 
                     select(slope) %>% unlist()
    state_slope  <- filter(state_model, ICD.Chapter == input$icd, State == input$state) %>% 
                    select(slope) %>% unlist()
    plot_ly(  x = "National Average" , y = nation_slope, type = 'bar', name = 'National Average') %>%
      add_trace(x = input$state, y = state_slope, name = input$state) %>%
      layout(yaxis = list(title = 'Slope'), barmode = 'group',
             title="Mortality Rate of Change")  
    
  })
}




