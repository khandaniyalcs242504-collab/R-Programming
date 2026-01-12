library(ggplot2)

walmart <- read.csv("Walmart_Sales.csv")

ggplot(walmart, aes(x = Weekly_Sales)) +
  geom_histogram(bins = 20, fill = "blue", color = "black") +
  labs(title = "Histogram of Weekly Sales",
       x = "Weekly Sales",
       y = "Frequency")

ggplot(walmart, aes(x = as.factor(Store), y = Weekly_Sales)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Box Plot of Weekly Sales by Store",
       x = "Store",
       y = "Weekly Sales")

