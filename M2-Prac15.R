library(writexl)

products <- read.csv("product_hierarchy.csv")

write.csv(products,
          "product_hierarchy_output.csv",
          row.names = FALSE)

write_xlsx(products,
           "product_hierarchy_output.xlsx")
library(writexl)

data <- read.csv("product_hierarchy.csv")
data <- head(data, 10)

lin_model <- lm(product_length ~ cluster_id, data = data)
lin_coefficients <- as.data.frame(summary(lin_model)$coefficients)

avg_length <- mean(data$product_length)
data$Is_Long_Product <- ifelse(data$product_length > avg_length, 1, 0)

log_model <- glm(Is_Long_Product ~ cluster_id,
                 data = data,
                 family = binomial)
log_coefficients <- as.data.frame(summary(log_model)$coefficients)

write.csv(data, "Regression_Data_S088.csv", row.names = FALSE)
write.csv(lin_coefficients, "Linear_Coefficients_S086.csv")
write.csv(log_coefficients, "Logistic_Coefficients_S086.csv")

write_xlsx(
  list(
    Regression_Data = data,
    Linear_Model = lin_coefficients,
    Logistic_Model = log_coefficients
  ),
  "Regression_Analysis_S086.xlsx"
)

pdf("Regression_Plots_S086.pdf", width = 8, height = 10)
par(mfrow = c(2, 1))

plot(data$cluster_id, data$product_length,
     main = "Linear Regression",
     xlab = "Cluster ID",
     ylab = "Product Length",
     pch = 19)
abline(lin_model, lwd = 2)

plot(data$cluster_id, data$Is_Long_Product,
     main = "Logistic Regression",
     xlab = "Cluster ID",
     ylab = "Probability",
     pch = 19)
curve(predict(log_model,
              data.frame(cluster_id = x),
              type = "response"),
      add = TRUE, lwd = 2)

dev.off()

products$Cluster_Binary <- ifelse(products$cluster_id == 1, 1, 0)

model <- glm(Cluster_Binary ~ product_length,
             data = products,
             family = binomial)

# SAFE PDF export 
pdf("product_logistic_regression_output.pdf")
plot.new()
text(0, 1, paste(capture.output(summary(model)), collapse = "\n"), adj = c(0,1))
dev.off()

