# Practical 2: Frequency Tables using CSV data

# Import product hierarchy dataset
products <- read.csv("product_hierarchy.csv")

# Using table()
table(products$cluster_id)

# Using count()
library(dplyr)
products %>% count(cluster_id)
