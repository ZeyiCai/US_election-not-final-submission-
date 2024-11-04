#### Preamble ####
# Purpose: Clean the raw data
# Author: Zeyi Cai
# Date: 3 November 2024
# Contact: zcloris.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: No
# Any other information needed? No

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)
library(janitor)

#### Clean data ####
# Load the raw simulated data
raw_data <- read_csv(file = "data/00-simulated_data/simulated_data.csv", 
                     show_col_types = FALSE)

#### Clean data ####
# Clean column names
cleaned_data <-
  clean_names(raw_data)
# Change the name
cleaned_data <-
  cleaned_data |>
  rename(percentage = pct
  )
# Select relevant columns
cleaned_data <-
  cleaned_data |>
  select(pollster, methodology, numeric_grade, state, candidate, 
         party, percentage, sample_size) 
head(cleaned_data)

cleaned_data <-
  cleaned_data |>
  filter(sample_size > 0) |>  # Ensure valid sample sizes
  mutate(percentage = if_else(percentage > 100, 100, percentage),  
      party = case_when(  # Standardize party names
      party == "REP" ~ "Republican",
      party == "DEM" ~ "Democrat",
     TRUE ~ party)) %>%
filter(
  numeric_grade >= 3.0,  # Filter numeric_grade >= 3.0
  candidate %in% c("Donald Trump", "Kamala Harris") ) # Filter for Trump and Harris
# Drop rows with any missing values
cleaned_data <- cleaned_data %>%
  drop_na()  

# Display the cleaned data
print(cleaned_data)

#### Save data ####
# Save the cleaned data to a CSV file
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")

