sales_data <- data.frame(
  Weekly_Sales = c(15000, 18000, 22000, 26000, 30000, 28000, 32000, 35000),
  Temperature = c(45, 50, 55, 60, 65, 62, 68, 70),
  Fuel_Price = c(2.5, 2.7, 2.8, 3.0, 3.2, 3.1, 3.3, 3.5),
  CPI = c(210, 212, 215, 218, 220, 219, 222, 225),
  Unemployment = c(7.0, 6.8, 6.5, 6.2, 6.0, 6.1, 5.8, 5.5)
)

correlation_matrix <- cor(sales_data)

print(correlation_matrix)