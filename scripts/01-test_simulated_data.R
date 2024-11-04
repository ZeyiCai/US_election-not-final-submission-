#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US presidential election dataset.
# Author: 
# Date: 20 October 2024
# Contact: 
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - Simulated election data CSV should be saved correctly.

#### Workspace setup ####
library(tidyverse)

# Load the dataset
simulated_data <- read_csv("/Users/zeyicai/Desktop/US_election/data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 100 rows (adjust based on your simulation size)
if (nrow(simulated_data) == 100) {
  message("Test Passed: The dataset has 100 rows.")
} else {
  stop("Test Failed: The dataset does not have 100 rows.")
}

# Check if the dataset has 8 columns 
expected_columns <- c("pollster", "methodology", "numeric_grade", 
                      "state", "candidate", "party", "pct", "sample_size")
if (all(names(simulated_data) %in% expected_columns)) {
  message("Test Passed: The dataset has the expected columns.")
} else {
  stop("Test Failed: The dataset does not have the expected columns.")
}

# Check if the 'candidate' column contains only valid candidates
valid_candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris", "Ron DeSantis")
if (all(simulated_data$candidate %in% valid_candidates)) {
  message("Test Passed: The 'candidate' column contains only valid candidate names.")
} else {
  stop("Test Failed: The 'candidate' column contains invalid candidate names.")
}

# Check if the 'party' column contains only valid party names
valid_parties <- c("REP", "DEM")
if (all(simulated_data$party %in% valid_parties)) {
  message("Test Passed: The 'party' column contains only valid party names.")
} else {
  stop("Test Failed: The 'party' column contains invalid party names.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if the 'pct' column values are within a valid range (0 to 100)
if (all(simulated_data$pct >= 0 & simulated_data$pct <= 100)) {
  message("Test Passed: The 'pct' column values are within the valid range (0-100).")
} else {
  stop("Test Failed: The 'pct' column contains values outside the valid range.")
}

# Check if the 'numeric_grade' column values are between 0 and 10
if (all(simulated_data$numeric_grade >= 0 & simulated_data$numeric_grade <= 10)) {
  message("Test Passed: The 'numeric_grade' column values are within the valid range (0-10).")
} else {
  stop("Test Failed: The 'numeric_grade' column contains values outside the valid range.")
}

# Check if the 'sample_size' column values are greater than zero
if (all(simulated_data$sample_size > 0)) {
  message("Test Passed: The 'sample_size' column values are positive.")
} else {
  stop("Test Failed: The 'sample_size' column contains non-positive values.")
}

# Check if there are no empty strings in key columns
if (all(simulated_data$pollster != "" & simulated_data$candidate != "" & 
        simulated_data$party != "")) {
  message("Test Passed: There are no empty strings in 'pollster', 'candidate', or 'party'.")
} else {
  stop("Test Failed: There are empty strings in one or more key columns.")
}

# Check if the 'candidate' column contains at least two unique values
if (n_distinct(simulated_data$candidate) >= 2) {
  message("Test Passed: The 'candidate' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'candidate' column contains less than two unique values.")
}



