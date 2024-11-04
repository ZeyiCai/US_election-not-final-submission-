#### Preamble ####
# Purpose: Clean the raw data
# Author: Zeyi Cai
# Date: 3 November 2024
# Contact: zcloris.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: No
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(modelsummary)

set.seed(123)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Model data ####
## Simple Linear Regression Model ##
simple_model <- lm(percentage ~ sample_size, data = poll_data)
summary(simple_model)  
plot(simple_model)

## Multiple Linear Regression Model ##
multiple_model <- lm(percentage ~ sample_size + numeric_grade + methodology + state + party, data = poll_data)
summary(multiple_model)  
plot(multiple_model)   

## Logistic Regression Model ##
analysis_data <- 
  analysis_data |> 
  slice_sample(n = 1000)
analysis_data <- analysis_data %>%
  mutate(
    # Create a binary response variable: 1 if Kamala Harris, 0 if Donald Trump
    harris_win = if_else(candidate == "Kamala Harris", 1, 0)) 
# Fit the logistic regression model using stan_glm
political_preferences <- stan_glm(
  harris_win ~ methodology + numeric_grade + state + party + sample_size + percentage,
  data = analysis_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
  seed = 123)
summary(political_preferences)
# Display model summary in a table format 
modelsummary(
  list("Support Harris" = political_preferences),
  statistic = "mad"
)
modelplot(political_preferences, conf_level = 0.9) +
  labs(x = "90 percent credibility interval", title = "Predictors of Support for Harris")

#### Save model ####
saveRDS(
  simple_model,
  file = "models/simple_model.rds"
)

saveRDS(
  multiple_model,
  file = "models/multiple_model.rds"
)
saveRDS(
  political_preferences, file = "political_preferences.rds"
  )