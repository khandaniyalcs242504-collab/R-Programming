# Practical 6: Paired t-test using CSV data

# Import Walmart sales dataset
walmart <- read.csv("Walmart_Sales.csv")

# Verify column names
colnames(walmart)

# Paired t-test
# Comparing Weekly Sales and Fuel Price (paired by store/date)
t.test(walmart$Weekly_Sales, walmart$Fuel_Price, paired = TRUE)
