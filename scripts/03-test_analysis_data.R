# Purpose: Test a simulated dataset
# Author: Xinxiang Gao
# Date: 26 November 2024
# Contact: xinxiang.gao@mail.utoronto.ca
# License: MIT

library(readr)
library(arrow)
library(validate)
analysis_data <- read_parquet("data/02-analysis_data/NFWBS_analysis_data.parquet")

# Define validation rules
rules <- validator(
  # Numeric ranges
  !is.na(FWBscore) & FWBscore >= 1 & FWBscore <= 79,
  !is.na(FSscore) & FSscore >= 1 & FSscore <= 77,
  !is.na(LMscore) & LMscore >= 0 & LMscore <= 3,
  !is.na(KHscore) & KHscore >= -2 & KHscore <= 1.267,
  !is.na(PUF_ID) & PUF_ID >= 7123 & PUF_ID <= 14400,

  # Categorical variables validation
  agecat %in% c("18-24", "25-34", "35-44", "45-54", "55-61", "62-69", "70-74", "75+"),
  PPEDUC %in% c(
    "Less than high school", "High school degree/GED", "Some college/Associate",
    "Bachelor's degree", "Graduate/professional degree"
  ),
  PPINCIMP %in% c(
    "Less than $20,000", "$20,000 to $29,999", "$30,000 to $39,999",
    "$40,000 to $49,999", "$50,000 to $59,999", "$60,000 to $74,999",
    "$75,000 to $99,999", "$100,000 to $149,999", "$150,000 or more"
  ),
  PPMARIT %in% c("Married", "Widowed", "Divorced/Separated", "Never married", "Living with partner"),
  HEALTH %in% c("Poor", "Fair", "Good", "Very good", "Excellent"),
  DISTRESS %in% c(
    "Strongly disagree", "Disagree", "Neither agree nor disagree",
    "Agree", "Strongly agree"
  ),

  # Structural checks
  is_unique(PUF_ID)
)

# Validate simulated data
validation_results <- confront(analysis_data, rules)

# Generate validation report
validation_summary <- summary(validation_results)
print(validation_summary)
