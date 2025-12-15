# Practical 7: One-Way ANOVA

products <- read.csv("product_hierarchy.csv")

# One-way ANOVA
anova_model <- aov(product_length ~ as.factor(cluster_id), data = products)

summary(anova_model)
