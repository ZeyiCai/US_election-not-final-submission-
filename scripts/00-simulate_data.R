#### Preamble ####
# Purpose: Simulates a dataset of US electoral divisions, including the
# state, sample size, and candidate support for each division.
# Author:
# Date: 20 October 2024
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)

# Set seed for reproducibility
set.seed(123)

# Define parameters
num_polls <- 100  
pollsters <- c("ActiVote", "TIPP Insights", "YouGov", "Ipsos")
methodologies <- c("Phone", "Online", "Mixed", "In-person")  
numeric_grades <- round(runif(num_polls, 1, 5), 1)  
states <- c("California", "Texas", "Florida", "New York", 
          "Ohio", "Georgia", "Michigan", "North Carolina")
parties <- c("REP", "DEM")
candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris", "Ron DeSantis")
sample_size_range <- c(1000, 3000)  

#### Simulate data ####
simulated_data <- tibble(
  pollster = sample(pollsters, num_polls, replace = TRUE),
  methodology = sample(methodologies, num_polls, replace = TRUE),
  numeric_grade = numeric_grades,
  state = sample(states, num_polls, replace = TRUE),
  party = sample(parties, num_polls, replace = TRUE),
  candidate = sample(candidates, num_polls, replace = TRUE),
  pct = round(runif(num_polls, 20, 60), 1),
  sample_size = sample(seq(sample_size_range[1], sample_size_range[2]), num_polls, replace = TRUE)
)
simulated_data

#### Average percentage per candidate ####
poll_result <- simulated_data %>%
  group_by(candidate) %>%
  summarize(average_pct = mean(pct))

# Display the results
print(poll_result)

#### Save data ####
# Save the simulated data to CSV
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
