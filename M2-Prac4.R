# Practical 4: One-Sample t-test using CSV data

# Import meat consumption dataset
meat <- read.csv("meat_consumption.csv")

# Verify column names
colnames(meat)

# Perform one-sample t-test
# Testing whether mean meat consumption value is equal to 50
t.test(meat$value, mu = 50)
