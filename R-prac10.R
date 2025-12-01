# ==============================================================================
# 10. Creating New Variables (Transformations & Calculations)
# Dataset: meat_consumption.csv
# ==============================================================================

library(dplyr)
library(tidyr)

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================

df <- read.csv("meat_consumption.csv", na.strings = c("", "NA"))

print("--- Original Data ---")
print(head(df))

# ==============================================================================
# PRE-CLEANING (if needed)
# ==============================================================================
# Replace NA in value with 0 for calculation demo

df_clean <- df %>%
  mutate(
    value = replace_na(value, 0)
  )

print("--- Cleaned Data ---")
print(head(df_clean))

# ==============================================================================
# 2. METHOD A: Arithmetic Calculations
# ==============================================================================

# Scenario:
# Create a new variable: Consumption_in_Tons
# 1 KG per capita → convert to Metric Tons (divide by 1000)

df_calc <- df_clean %>%
  mutate(
    value_in_tons = value / 1000,
    
    # Increase consumption by 10% (example transformation)
    projected_next_year = value * 1.10
  )

print("--- Method A: Arithmetic Transformations ---")
print(df_calc %>% select(value, value_in_tons, projected_next_year) %>% head())

# ==============================================================================
# 3. METHOD B: Conditional Logic (ifelse)
# ==============================================================================

# Scenario:
# Create a "Consumption_Level" label:
# If value > 30 KG per person → High Consumption, else Low Consumption

df_logic <- df_clean %>%
  mutate(
    Consumption_Level = ifelse(value > 30, "High", "Low"),
    
    # Condition on year: before 2000 vs after 2000
    Period = ifelse(time < 2000, "Before 2000", "2000 & After")
  )

print("--- Method B: Conditional Labels ---")
print(df_logic %>% select(time, value, Consumption_Level, Period) %>% head())
