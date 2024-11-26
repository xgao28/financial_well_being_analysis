# Purpose: Test a simulated dataset
# Author: Xinxiang Gao
# Date: 26 November 2024
# Contact: xinxiang.gao@mail.utoronto.ca
# License: MIT

library(readr)
library(validate)
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")
rules <- validator(
  !is.na(FWBscore) & FWBscore >= 1 & FWBscore <= 79,   # FWBscore: Check for non-null and range
  !is.na(FSscore) & FSscore >= 1 & FSscore <= 77,       # FSscore: Check for non-null and range
  !is.na(LMscore) & LMscore >= 0 & LMscore <= 3,         # LMscore: Check for non-null and range
  !is.na(KHscore) & KHscore >= -3 & KHscore <= 1.267,    # KHscore: Check for non-null and range
  !is.na(finalwt) & finalwt >= 0 & finalwt <= 6.64,   # finalwt: Check for non-null and range
  !is.na(PUF_ID) & PUF_ID >= 7123 & PUF_ID <= 14400      # PUF_ID: Check for non-null and range
)

# Apply the validation rules to the simulated data
validation_results <- confront(data_simulated, rules)

# View the validation results
summary(validation_results)

