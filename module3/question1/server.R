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

state<-data.frame(State=state.abb,StateName=state.name, stringsAsFactors = F)
cdc.df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header= TRUE, stringsAsFactors = F)
colnames(cdc.df)[1] <- "Cause"
colnames(cdc.df)[6] <- "Mortality"
cdc.df <- cdc.df %>% left_join(state) %>% select(Cause, StateName, Year, Deaths, Population, Mortality)
colnames(cdc.df)[2] <- "State"
cdc.df <- cdc.df %>%
  mutate(State = if_else(is.na(State), 'Washington DC', State))

cdc.df <- data.frame(cdc.df)

shinyServer(function(input, output) {
  
  output$yearOutput <- renderUI({
    selectInput("yearInput", "Select Year",
                sort(unique(cdc.df$Year)),
                selected = "2010")
  })
  
  output$causeOutput <- renderUI({
    selectInput("causeInput", "Select Cause",
                sort(unique(cdc.df$Cause)),
                selected = "Neoplasms")
  })
  
  filtered <- reactive({
    if (is.null(input$yearInput)) {
      return(NULL)
    }
    if (is.null(input$causeInput)) {
      return(NULL)
    }
    if (is.null(input$rankInput)) {
      return(NULL)
    }
    if (is.null(input$orderInput)) {
      return(NULL)
    }
    
    if (input$rankInput=='Min. Rank'){
      if (input$orderInput=="Low To High"){
        cdc.df %>%
          filter(Year == input$yearInput,
                 Cause == input$causeInput) %>% 
          arrange(State) %>% 
          mutate(Rank = min_rank(Mortality)) %>% 
          select(Rank, Cause, State, Year, Deaths, Population, Mortality)
      }
      else {
        cdc.df %>%
          filter(Year == input$yearInput,
                 Cause == input$causeInput) %>% 
          arrange(State) %>% 
          mutate(Rank = min_rank(desc(Mortality))) %>% 
          select(Rank, Cause, State, Year, Deaths, Population, Mortality)
      }
    }
    else {
      if (input$orderInput=="Low To High"){
        cdc.df %>%
          filter(Year == input$yearInput,
                 Cause == input$causeInput) %>% 
          arrange(State) %>% 
          mutate(Rank = dense_rank(Mortality)) %>% 
          select(Rank, Cause, State, Year, Deaths, Population, Mortality)
      }
      else {
        cdc.df %>%
          filter(Year == input$yearInput,
                 Cause == input$causeInput) %>% 
          arrange(State) %>% 
          mutate(Rank = dense_rank(desc(Mortality))) %>% 
          select(Rank, Cause, State, Year, Deaths, Population, Mortality)
      }
    }
  })
  
  output$plot3 <- renderPlotly({
    margin.val <- list(b=120, t=50) # l = left; r = right; t = top; b = bottom
    
    plot <- plot_ly(filtered(), x = ~reorder(State, State), y = ~Mortality, colors = "grey",  
                    hoverinfo = 'text', text = ~paste('State: ', State,'<br> Mortality: ', Mortality, 
                                                      '<br> Rank: ', Rank, 
                                                      '<br> Population: ', Population, 
                                                      '<br> Deaths: ', Deaths)) %>% 
      layout(title = paste0("Crude Mortality Rate ", input$yearInput,'<br>','Cause: ',input$causeInput),
             xaxis = list(title = paste("State - ", input$orderInput), showgrid = TRUE, tickangle = -45, tickfont=list(size=8)),
             yaxis = list(title = "Mortality Rate", showgrid = TRUE),
             margin=margin.val,   title =list(tickfont = list(size = 11)))
    plot
  })
  
  output$plot4 <- renderPlotly({
    margin.val <- list(b=120, t=50) # l = left; r = right; t = top; b = bottom
    plot <- plot_ly(filtered(), x = ~State, y = ~Mortality, type = 'scatter', mode = 'markers', color = ~Rank,
                 marker = list(size = 10, opacity = 0.5), hoverinfo = 'text', text = ~paste('State: ', State, 
                                                                                            '<br> Mortality: ', Mortality, 
                                                                                            '<br> Rank: ', Rank, 
                                                                                            '<br> Population: ', Population, 
                                                                                            '<br> Deaths: ', Deaths), name=" ")
    
    plot <- plot %>%
      layout(title = paste0("Crude Mortality Rate Accross All States - ", input$yearInput,'<br>','Cause: ',input$causeInput),
             xaxis = list(title = paste("State - ", input$orderInput), showgrid = TRUE, tickangle = -45, tickfont=list(size=8)),
             yaxis = list(title = "Mortality Rate Per 100,000 Population", showgrid = TRUE),
             margin=margin.val,  title =list(tickfont = list(size = 11)))
    
    plot
  })
  
  output$results <- renderDataTable({
    if (is.null(filtered())) {
      return()
    }
    datatable(filtered(), class = 'cell-border stripe', options = list(searching = FALSE), rownames= FALSE)
    
  })
  
})
