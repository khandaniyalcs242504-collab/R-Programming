# ==============================================================================
# R Script: Reshaping Data with pivot_longer() and pivot_wider()
# Dataset: Cleaned Student Mental Health Data (Auto-Adaptive)
# ==============================================================================

library(dplyr)
library(tidyr)

# ==============================================================================
# 1. SETUP: Import Data
# ==============================================================================

df <- read.csv("Cleaned_Student_Mental_Health.csv", na.strings = c("", "NA"))

# Add unique ID for tracking
df <- df %>%
  mutate(StudentID = row_number())

print("--- 1. Original Data ---")
print(head(df))

# ==============================================================================
# 2. AUTO PIVOT_LONGER (Wide to Long)
# Automatically selects ALL numeric columns
# ==============================================================================

numeric_cols <- df %>% select(where(is.numeric)) %>% colnames()

long_df <- df %>%
  pivot_longer(
    cols = all_of(numeric_cols),
    names_to = "Metric",
    values_to = "Value"
  )

print("--- 2. Long Format (pivot_longer) ---")
print(head(long_df, 6))

# ==============================================================================
# 3. AUTO PIVOT_WIDER (Long to Wide)
# ==============================================================================

wide_df <- long_df %>%
  pivot_wider(
    names_from = Metric,
    values_from = Value
  )

print("--- 3. Wide Format (pivot_wider) ---")
print(head(wide_df))

# ==============================================================================
# 4. ADVANCED REPORT (Categorical vs Numeric Auto Pivot)
# ==============================================================================

# Find first categorical column automatically
category_col <- df %>% select(where(is.character)) %>% colnames() %>% .[1]

if (!is.na(category_col)) {
  report_pivot <- df %>%
    group_by(.data[[category_col]]) %>%
    summarise(across(where(is.numeric), mean, na.rm = TRUE)) %>%
    pivot_wider(
      names_from = .data[[category_col]],
      values_from = where(is.numeric)
    )
  
  print("--- 4. Automatic Category Report Pivot ---")
  print(report_pivot)
} else {
  print("--- 4. No categorical column found for report pivot ---")
}
