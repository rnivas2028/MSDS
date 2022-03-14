library(ggplot2)
library(dplyr)
library(plotly)
library(tidyr)
library(purrr)

df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header= TRUE, stringsAsFactors = F)
df <- df %>% filter(ICD.Chapter != "Codes for special purposes",
                    ICD.Chapter != "Pregnancy, childbirth and the puerperium",
                    ICD.Chapter != "Diseases of the ear and mastoid process")

# create the national average per ICD per year
df %>% 
  group_by(ICD.Chapter, Year) %>% 
  summarise(Deaths = sum(Deaths),
            Population = sum(Population),
            Crude.Rate = Deaths/Population * 100000) %>% 
  mutate(State = "National Average") %>% 
  select(ICD.Chapter, State, Year, Deaths, Population, Crude.Rate) -> nation_avg_df
# ===================================== #
# lm functions 
# ===================================== #
doModel <- function(dat) lm(Crude.Rate ~ Year, dat)
getSlope <- function(mod) coef(mod)[2]

# ======================================= #
# Linear Regression Model - National Data 
# ======================================= #
nation_avg_df %>% 
   select(ICD.Chapter, Year, Crude.Rate) %>% 
   group_by(ICD.Chapter) %>% nest %>%
   mutate(model = map(data, doModel)) %>% 
   mutate(slope = map(model, getSlope)) -> nation_model

# ======================================= #
# Linear Regression Model - State Data 
# ======================================= #
df %>% 
  select(ICD.Chapter, State, Year, Crude.Rate) %>% 
  group_by(ICD.Chapter, State) %>% nest %>%
  mutate(model = map(data, doModel)) %>% 
  mutate(slope = map(model, getSlope)) -> state_model




