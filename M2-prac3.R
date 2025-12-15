# Practical 3: Cross Tabulation using CSV data

# Import the sales dataset
sales <- read.csv("sales_data - sales_data.csv")

# Display column names (verification step)
colnames(sales)


cross_table <- table(sales$Region, sales$Product_Category)

# Display the cross-tabulation
cross_table
