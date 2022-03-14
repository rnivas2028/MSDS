#-----------------------------------------------------------------------------#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#-----------------------------------------------------------------------------#

#Question 2: Often you are asked whether particular States are improving their 
# mortality rates (per cause) faster than, or slower than, the national average. 
# Create a visualization that lets your clients see this for themselves for one cause of death at the time. 
# Keep in mind that the national average should be weighted by the national population.
#-----------------------------------------------------------------------------#

library(shiny)
library(plotly)
# Use a fluid Bootstrap layout

shinyUI(fluidPage(
  titlePanel("Mortality Rates - National Average vs. State"),
  fluidRow(
    column(3, style = "background-color:#e0e0dc",
           wellPanel(selectInput("state", "Select State",
                                 choices = unique(df$State)),
                     selectInput("icd", "Cause of Death ",
                                 choices = sort(unique(df$ICD.Chapter)))
           )
    ),
    column(8,
           fluidRow(
             splitLayout(cellWidths = c("50%", "50%"),
                         plotlyOutput("plot1"), plotlyOutput("plot2"))
           )
    )
  )
))