library(ggplot2)
library(writexl)

titanic <- read.csv("Processed_Titanic_Data.csv")
titanic_10 <- titanic[1:10, ]

lin_model <- lm(fare ~ age, data = titanic_10)
lin_coefficients <- as.data.frame(summary(lin_model)$coefficients)

log_model <- glm(survived ~ age,
                 data = titanic_10,
                 family = binomial)

log_coefficients <- as.data.frame(summary(log_model)$coefficients)

titanic_10$predicted_prob <- predict(log_model, type = "response")

write.csv(titanic_10,
          "Titanic_Regression_Data.csv",
          row.names = FALSE)

write.csv(lin_coefficients,
          "Titanic_Linear_Coefficients.csv")

write.csv(log_coefficients,
          "Titanic_Logistic_Coefficients.csv")

write_xlsx(
  list(
    Titanic_Data = titanic_10,
    Linear_Model = lin_coefficients,
    Logistic_Model = log_coefficients
  ),
  "Titanic_Regression_Analysis.xlsx"
)

pdf("Titanic_Regression_Plots.pdf", width = 8, height = 10)
par(mfrow = c(2, 1))

plot(titanic_10$age, titanic_10$fare,
     main = "Linear Regression: Age vs Fare",
     xlab = "Age",
     ylab = "Fare",
     pch = 19,
     col = "steelblue")
abline(lin_model, col = "darkred", lwd = 2)

plot(titanic_10$age, titanic_10$predicted_prob,
     main = "Logistic Regression: Age vs Survival Probability",
     xlab = "Age",
     ylab = "Probability of Survival",
     pch = 19,
     col = "darkgreen")
lines(sort(titanic_10$age),
      predict(log_model,
              data.frame(age = sort(titanic_10$age)),
              type = "response"),
      col = "orange",
      lwd = 2)

dev.off()
