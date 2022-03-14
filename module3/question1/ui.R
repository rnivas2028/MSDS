#-----------------------------------------------------------------------------#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#-----------------------------------------------------------------------------#

# Question 1: As a researcher, you frequently compare mortality rates from particular causes across
# different States. You need a visualization that will let you see (for 2010 only) the crude
# mortality rate, across all States, from one cause (for example, Neoplasms, which are
# effectively cancers). Create a visualization that allows you to rank States by crude mortality
# for each cause of death.
#-----------------------------------------------------------------------------#

library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("2010 US States Mortality Rates"),
  fluidRow(
    column(3, style = "background-color:#e0e0dc",wellPanel(
        uiOutput("yearOutput"),
        uiOutput("causeOutput"),
        selectInput("rankInput", "Select Rank Type",
                    choices = c("Min. Rank", "Dense Rank"),
                    selected = "Min. Rank"),
        selectInput("orderInput", "Select Mortality Order",
                    choices = c("Low To High", "High To Low"),
                    selected = "High To Low")
      )
    ),
    column(8,
           tabsetPanel(tabPanel("Mortality Rates Chart with Rank",
                      plotlyOutput("plot3")),
             tabPanel("Mortality Rates Chart",
                      plotlyOutput("plot4"))
         )
      )
    )
  )
)