# Load required library
library(ggplot2)

# Load dataset
titanic <- read.csv("Processed_Titanic_Data.csv")

# Take only first 10 records (as per your earlier requirement)
titanic_10 <- titanic[1:10, ]

# Logistic Regression Model
logit_model <- glm(survived ~ age,
                   data = titanic_10,
                   family = binomial)

# Model summary
summary(logit_model)

# Predicted probabilities
titanic_10$predicted_prob <- predict(logit_model, type = "response")

# Plot: Age vs Survival Probability
ggplot(titanic_10, aes(x = age, y = predicted_prob)) +
  geom_point(color = "blue", size = 3) +
  geom_line(color = "red") +
  labs(
    title = "Logistic Regression: Age vs Survival Probability",
    x = "Age",
    y = "Probability of Survival"
  ) +
  theme_minimal()
