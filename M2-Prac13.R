# Load library
library(ggplot2)

# Load dataset
titanic <- read.csv("Processed_Titanic_Data.csv")

# Take only first 10 rows
titanic_10 <- titanic[1:10, ]

# Linear Regression Model
lm_model <- lm(fare ~ age, data = titanic_10)

# Model summary
summary(lm_model)

# Plot
ggplot(titanic_10, aes(x = age, y = fare)) +
  geom_point(color = "blue", size = 3) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Linear Regression (First 10 Records - Titanic)",
    x = "Age",
    y = "Fare"
  ) +
  theme_minimal()
