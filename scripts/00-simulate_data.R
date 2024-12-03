# Purpose: Simulate an expected dataset
# Author: Xinxiang Gao
# Date: 26 November 2024
# Contact: xinxiang.gao@mail.utoronto.ca
# License: MIT

library(arrow)

set.seed(2690) # Set seed for reproducibility

# Define categorical variables and their levels
agecat_levels <- c("18-24", "25-34", "35-44", "45-54", "55-61", "62-69", "70-74", "75+")
ppeduc_levels <- c(
  "Less than high school", "High school degree/GED", "Some college/Associate",
  "Bachelor's degree", "Graduate/professional degree"
)
ppincimp_levels <- c(
  "Less than $20,000", "$20,000 to $29,999", "$30,000 to $39,999",
  "$40,000 to $49,999", "$50,000 to $59,999", "$60,000 to $74,999",
  "$75,000 to $99,999", "$100,000 to $149,999", "$150,000 or more"
)
ppmarit_levels <- c("Married", "Widowed", "Divorced/Separated", "Never married", "Living with partner")
health_levels <- c("Poor", "Fair", "Good", "Very good", "Excellent")
distress_levels <- c(
  "Strongly disagree", "Disagree", "Neither agree nor disagree",
  "Agree", "Strongly agree"
)

# Number of observations
n <- 1000

# Simulate original variables
FWBscore <- sample(1:79, n, replace = TRUE)
FSscore <- sample(1:77, n, replace = TRUE)
LMscore <- sample(0:3, n, replace = TRUE)
KHscore <- runif(n, min = -2, max = 1.267)
PUF_ID <- sample(7123:14400, n, replace = FALSE)

# Simulate new categorical variables
agecat <- factor(sample(agecat_levels, n, replace = TRUE), levels = agecat_levels)
PPEDUC <- factor(sample(ppeduc_levels, n, replace = TRUE), levels = ppeduc_levels)
PPINCIMP <- factor(sample(ppincimp_levels, n, replace = TRUE), levels = ppincimp_levels)
PPMARIT <- factor(sample(ppmarit_levels, n, replace = TRUE), levels = ppmarit_levels)
HEALTH <- factor(sample(health_levels, n, replace = TRUE), levels = health_levels)
DISTRESS <- factor(sample(distress_levels, n, replace = TRUE), levels = distress_levels)

# Create the data frame
data_simulated <- data.frame(
  PUF_ID = PUF_ID,
  FWBscore = FWBscore,
  FSscore = FSscore,
  LMscore = LMscore,
  KHscore = KHscore,
  agecat = agecat,
  PPEDUC = PPEDUC,
  PPINCIMP = PPINCIMP,
  PPMARIT = PPMARIT,
  HEALTH = HEALTH,
  DISTRESS = DISTRESS
)

# Save as Parquet using arrow
write_parquet(data_simulated, "data/00-simulated_data/simulated_data.parquet")
