# ==============================================================================
# R Script: Generating Basic Summaries
# Functions: str() and summary()
# Dataset: sales_data - sales_data.csv
# ==============================================================================

# ==============================================================================
# 1. SETUP: Import Dataset
# ==============================================================================

sales_df <- read.csv("sales_data - sales_data.csv", na.strings = c("", "NA"))

print("--- Data Loaded (Preview) ---")
print(head(sales_df))

# ==============================================================================
# 2. USING str() (Structure)
# ==============================================================================

print("--- OUTPUT OF str() ---")
str(sales_df)

# ==============================================================================
# 3. USING summary() (Statistical Summary)
# ==============================================================================

print("--- OUTPUT OF summary() [Before Factor Conversion] ---")
summary(sales_df)

# ==============================================================================
# 4. IMPROVING summary() WITH FACTORS (AUTO-DETECTED)
# ==============================================================================

# Automatically convert all character columns into factors
sales_df <- sales_df %>%
  mutate(across(where(is.character), as.factor))

print("--- OUTPUT OF summary() [After Factor Conversion] ---")
summary(sales_df)

# ==============================================================================
# 5. ACCESSING SPECIFIC SUMMARIES (AUTO-DETECTED NUMERIC)
# ==============================================================================

# Automatically select a numeric column for stats
numeric_cols <- sales_df %>% select(where(is.numeric)) %>% colnames()

if (length(numeric_cols) > 0) {
  avg_value <- mean(sales_df[[numeric_cols[1]]], na.rm = TRUE)
  max_value <- max(sales_df[[numeric_cols[1]]], na.rm = TRUE)
  
  print(paste("Average of", numeric_cols[1], ":", avg_value))
  print(paste("Maximum of", numeric_cols[1], ":", max_value))
} else {
  print("No numeric columns found for summary statistics.")
}
 