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
library(car)  

#### Load Data ####
# Load the dataset 
poll_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Data Inspection ####
# View data structure and summary statistics
print(head(poll_data))
summary(poll_data)
glimpse(poll_data)

#### Convert Categorical Variables to Factors ####
# Convert relevant columns to factors for modeling
poll_data <- poll_data %>%
  mutate(
    pollster = as.factor(pollster),
    methodology = as.factor(methodology),
    state = as.factor(state),
    party = as.factor(party),
    candidate = as.factor(candidate)
  )

#### EDA: Exploratory Data Analysis ####
# Distribution of Polling Percentages
poll_data |>
  ggplot(aes(x = percentage)) +
  geom_histogram(bins = 30)

poll_data |>
  ggplot(aes(x = percentage)) +
  geom_histogram(bins = 30) +
  scale_x_log10()

# Distribution of Sample Sizes
poll_data |>
  ggplot(aes(x = sample_size)) +
  geom_histogram(binwidth = 100) 

# Candidate Support by Methodology
poll_data |>
  ggplot(aes(x = methodology, y = percentage, fill = methodology)) +
  geom_boxplot() +
  labs(title = "Support Percentage by Polling Methodology", x = "Methodology", y = "Percentage") +
  theme_minimal()


# Support Percentage by State and Party
poll_data |>
  ggplot(aes(x = state, y = percentage, fill = party)) +
  geom_boxplot() +
  labs(title = "Support Percentage by State and Party", x = "State", y = "Percentage") +
  theme_minimal() 

