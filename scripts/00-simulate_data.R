# Purpose: Simulate an expected dataset
# Author: Xinxiang Gao
# Date: 26 November 2024
# Contact: xinxiang.gao@mail.utoronto.ca
# License: MIT


set.seed(2690)  # Set seed for reproducibility

# Number of observations
n <- 1000

# Simulate FWBscore (random values between 1 and 79)
FWBscore <- sample(1:79, n, replace = TRUE)

# Simulate FSscore (random values between 1 and 77)
FSscore <- sample(1:77, n, replace = TRUE)

# Simulate LMscore (random values between 0 and 3)
LMscore <- sample(0:3, n, replace = TRUE)

# Simulate KHscore (random values between -2 and 1.267)
KHscore <- runif(n, min = -2, max = 1.267)  # Uniform random distribution

# Simulate finalwt (random values between 0.17 and 6.64)
finalwt <- runif(n, min = 0, max = 6.64)  # Uniform random distribution

# Simulate PUF_ID (random values between 1 and 14400)
PUF_ID <- sample(7123:14400, n, replace = FALSE)

# Create the data frame
data_simulated <- data.frame(
  PUF_ID = PUF_ID,
  FWBscore = FWBscore,
  FSscore = FSscore,
  LMscore = LMscore,
  KHscore = KHscore,
  finalwt = finalwt
)

write.csv(data_simulated, "data/00-simulated_data/simulated_data.csv", row.names = FALSE)

