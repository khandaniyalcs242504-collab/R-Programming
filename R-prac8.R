# ==============================================================================
# R Script: Handling Missing Values (Data Cleaning)
# Dataset: product_hierarchy.csv
# ==============================================================================

library(dplyr)
library(tidyr)

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================

df <- read.csv("product_hierarchy.csv", na.strings = c("", "NA"))

print("--- 1. Original Data (First 6 Rows) ---")
print(head(df))

# Count missing values in each column
print("--- Missing Values per Column ---")
print(colSums(is.na(df)))

# ==============================================================================
# 2. METHOD A: REMOVE MISSING VALUES (na.omit)
# ==============================================================================

clean_omit <- na.omit(df)

print("--- 2. Data After Removing Missing Rows (na.omit) ---")
print(paste("Original rows:", nrow(df)))
print(paste("Remaining rows:", nrow(clean_omit)))
print(head(clean_omit))

# ==============================================================================
# 3. METHOD B: REPLACE MISSING VALUES (replace_na)
# ==============================================================================

# Filling logic:
# - Numeric columns → fill with mean
# - cluster_id → fill with "Unknown"
# - hierarchy columns → fill with "Missing"

avg_length <- mean(df$product_length, na.rm = TRUE)
avg_depth  <- mean(df$product_depth, na.rm = TRUE)
avg_width  <- mean(df$product_width, na.rm = TRUE)

clean_replace <- df %>%
  replace_na(list(
    product_length = avg_length,
    product_depth  = avg_depth,
    product_width  = avg_width,
    cluster_id     = "Unknown",
    hierarchy1_id  = "Missing",
    hierarchy2_id  = "Missing",
    hierarchy3_id  = "Missing",
    hierarchy4_id  = "Missing",
    hierarchy5_id  = "Missing"
  ))

print("--- 3. Data After Replacing Missing Values ---")
print(head(clean_replace))

# Check remaining NAs
print("--- Remaining NAs After Cleaning ---")
print(colSums(is.na(clean_replace)))
