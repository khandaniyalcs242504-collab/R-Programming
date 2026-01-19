library(writexl)

products <- read.csv("product_hierarchy.csv")

write.csv(products,
          "product_hierarchy_output.csv",
          row.names = FALSE)

write_xlsx(products,
           "product_hierarchy_output.xlsx")

products$Cluster_Binary <- ifelse(products$cluster_id == 1, 1, 0)

model <- glm(Cluster_Binary ~ product_length,
             data = products,
             family = binomial)

# SAFE PDF export 
pdf("product_logistic_regression_output.pdf")
plot.new()
text(0, 1, paste(capture.output(summary(model)), collapse = "\n"), adj = c(0,1))
dev.off()

