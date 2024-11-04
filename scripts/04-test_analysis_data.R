#### Preamble ####
# Purpose: Test analysis data
# Author: Zeyi Cai
# Date: 3 November 2024
# Contact: zcloris.cai@mail.utoronto.ca
# License: MIT
# Pre-requisites: No
# Any other information needed? No

#### Workspace setup ####
library(testthat)
library(readr)
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

#### Test data ####
# Test that the dataset has the expected number of rows (adjust as needed)
expected_row_count <- 100  
test_that("dataset has expected number of rows", {
  expect_equal(nrow(analysis_data), expected_row_count)
})

# Test that the dataset has 8 columns
expected_column_count <- 8
test_that("dataset has 8 columns", {
  expect_equal(ncol(analysis_data), expected_column_count)
})

# Test that specific columns are of the correct type
test_that("'pollster' is character", {
  expect_type(analysis_data$pollster, "character")
})
test_that("'methodology' is character", {
  expect_type(analysis_data$methodology, "character")
})
test_that("'numeric_grade' is numeric", {
  expect_type(analysis_data$numeric_grade, "double")
})
test_that("'state' is character", {
  expect_type(analysis_data$state, "character")
})
test_that("'candidate' is character", {
  expect_type(analysis_data$candidate, "character")
})
test_that("'party' is character", {
  expect_type(analysis_data$party, "character")
})
test_that("'percentage' is numeric", {
  expect_type(analysis_data$percentage, "double")
})
test_that("'sample_size' is integer", {
  expect_type(analysis_data$sample_size, "integer")
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})


# Test that 'state' contains only valid US state names
valid_states <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", 
                  "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", 
                  "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", 
                  "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", 
                  "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", 
                  "New Hampshire", "New Jersey", "New Mexico", "New York", 
                  "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", 
                  "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", 
                  "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", 
                  "West Virginia", "Wisconsin", "Wyoming")
test_that("'state' contains valid US state names", {
  expect_true(all(analysis_data$state %in% valid_states))
})

# Test that there are no empty strings in 'pollster', 'candidate', 'party', or 'state' columns
test_that("no empty strings in 'pollster', 'candidate', 'party', or 'state' columns", {
  expect_false(any(analysis_data$pollster == "" | analysis_data$candidate == "" |
                     analysis_data$party == "" | analysis_data$state == ""))
})

# Test that the 'party' column contains at least 2 unique values
test_that("'party' column contains at least 2 unique values", {
  expect_true(length(unique(analysis_data$party)) >= 2)
})
