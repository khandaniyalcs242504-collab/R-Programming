# ==============================================================================
# R Script: Extracting Date Components using lubridate
# Dataset: Processed_Titanic_Data.csv (Auto-Adaptive)
# ==============================================================================

# Install required packages (run once only)
# install.packages("lubridate")
# install.packages("dplyr")

# Load necessary libraries
library(lubridate)
library(dplyr)

# ==============================================================================
# 1. SETUP: Import Dataset
# ==============================================================================

titanic_df <- read.csv("Processed_Titanic_Data.csv", na.strings = c("", "NA"))

print("--- Original Dataset Preview ---")
print(head(titanic_df))

# ==============================================================================
# 2. AUTO-DETECT A DATE COLUMN
# ==============================================================================

# Find possible date columns by attempting to parse character columns
date_column <- NULL

for (col in colnames(titanic_df)) {
  if (is.character(titanic_df[[col]]) || inherits(titanic_df[[col]], "Date")) {
    parsed <- suppressWarnings(ymd(titanic_df[[col]]))
    if (sum(!is.na(parsed)) > 0) {
      date_column <- col
      titanic_df[[col]] <- parsed
      break
    }
  }
}

if (is.null(date_column)) {
  stop("No valid date column found in the dataset.")
}

print(paste("--- Date Column Detected:", date_column, "---"))

# ==============================================================================
# 3. EXTRACT DATE COMPONENTS
# ==============================================================================

processed_data <- titanic_df %>%
  mutate(
    Year_Num      = year(.data[[date_column]]),
    Month_Num     = month(.data[[date_column]]),
    Month_Name    = month(.data[[date_column]], label = TRUE),
    Day_Num       = day(.data[[date_column]]),
    Weekday_Num   = wday(.data[[date_column]]),
    Weekday_Name  = wday(.data[[date_column]], label = TRUE, abbr = FALSE),
    Quarter       = quarter(.data[[date_column]]),
    Day_of_Year   = yday(.data[[date_column]])
  )

print("--- Data with Extracted Date Components ---")
print(head(processed_data))

# ==============================================================================
# 4. SYSTEM DATE: Handling "Now"
# ==============================================================================

current_time <- now()

print("--- Current Time Extraction ---")
print(paste("Current Year:", year(current_time)))
print(paste("Current Month:", month(current_time)))
print(paste("Current Day:", day(current_time)))
print(paste("Current Hour:", hour(current_time)))
print(paste("Current Minute:", minute(current_time)))
