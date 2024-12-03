# Purpose: Cleans the raw data after download
# Author: CFPB, Xinxiang Gao
# Date: 26 November 2024
# Contact: xinxiang.gao@mail.utoronto.ca
# License: MIT
# Acknowledgements: Remapping value below utilized provided Code for analytics tools from CFPB.
# https://www.consumerfinance.gov/documents/5600/NFWBS_PUF_2016_read_in_R.R


# The plyr library will be used to help us remap values
library(plyr)
library(dplyr)
library(arrow)



# Load the data in to a dataframe for later use, please enter the appropriate path for the CSV.
df <- read.csv("data/01-raw_data/NFWBS_PUF_2016_data.csv")

# Keep only data of interest and puf_id
df <- df %>% select(PUF_ID, agecat, PPEDUC, PPINCIMP, PPMARIT, HEALTH, DISTRESS, FWBscore, FSscore, KHscore, LMscore)

# Remap values for agecat, PPEDUC, PPINCIMP, PPMARIT, HEALTH, DISTRESS

df$agecat = revalue(factor(df$agecat), c(
  `1` = "18-24",
  `2` = "25-34",
  `3` = "35-44",
  `4` = "45-54",
  `5` = "55-61",
  `6` = "62-69",
  `7` = "70-74",
  `8` = "75+"
))

df$PPEDUC = revalue(factor(df$PPEDUC), c(
  `1` = "Less than high school",
  `2` = "High school degree/GED",
  `3` = "Some college/Associate",
  `4` = "Bachelor's degree",
  `5` = "Graduate/professional degree"
))

df$PPINCIMP = revalue(factor(df$PPINCIMP), c(
  `1` = "Less than $20,000",
  `2` = "$20,000 to $29,999",
  `3` = "$30,000 to $39,999",
  `4` = "$40,000 to $49,999",
  `5` = "$50,000 to $59,999",
  `6` = "$60,000 to $74,999",
  `7` = "$75,000 to $99,999",
  `8` = "$100,000 to $149,999",
  `9` = "$150,000 or more"
))

df$PPMARIT = revalue(factor(df$PPMARIT), c(
  `1` = "Married",
  `2` = "Widowed",
  `3` = "Divorced/Separated",
  `4` = "Never married",
  `5` = "Living with partner"
))

df$HEALTH = revalue(factor(df$HEALTH), c(
  `-1` = "Refused",
  `1` = "Poor",
  `2` = "Fair",
  `3` = "Good",
  `4` = "Very good",
  `5` = "Excellent"
))

df$DISTRESS = revalue(factor(df$DISTRESS), c(
  `-1` = "Refused",
  `1` = "Strongly disagree",
  `2` = "Disagree",
  `3` = "Neither agree nor disagree",
  `4` = "Agree",
  `5` = "Strongly agree"
))

df$FWBscore = revalue(factor(df$FWBscore), c(
  `-4` = "Response not written to database",
  `-1` = "Refused"
))

df$FSscore = revalue(factor(df$FSscore), c(
  `-1` = "Refused"
))


# Filter out rows where FWBscore or FSscore is "Refused", and FWBscore is not "Response not written to database"
data_cleaned <- subset(df, FWBscore != "Refused" & FSscore != "Refused" & FWBscore != "Response not written to database")

# filter all_of(c("agecat", "PPEDUC", "PPINCIMP", "PPMARIT", "HEALTH", "DISTRESS")) are "Refused"
data_cleaned <- subset(data_cleaned, agecat != "Refused" 
                       & PPEDUC != "Refused" 
                       & PPINCIMP != "Refused" 
                       & PPMARIT != "Refused" 
                       & HEALTH != "Refused" 
                       & DISTRESS != "Refused")

# Convert FWBscore and FSscore to numeric
data_cleaned$FWBscore <- as.numeric(data_cleaned$FWBscore)
data_cleaned$FSscore <- as.numeric(data_cleaned$FSscore)


# Write cleaned data to parquet file
write_parquet(data_cleaned, "data/02-analysis_data/NFWBS_analysis_data.parquet")
