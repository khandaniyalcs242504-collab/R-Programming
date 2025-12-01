# ==============================================================================
# Pract 9: Text Manipulation using str_sub(), str_split()
# Dataset: ADANIPORTS.csv
# ==============================================================================

install.packages("stringr")
library(stringr)
library(dplyr)
library(tidyr)

# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================

stock <- read.csv("ADANIPORTS.csv", na.strings = c("", "NA"))

print("--- Original Dataset ---")
print(head(stock))

# ==============================================================================
# 2. USING str_sub() — Extracting Substrings
# ==============================================================================

# Example A: Extract YEAR from Date (first 4 characters)
stock$Year <- str_sub(stock$Date, 1, 4)

# Example B: Extract MONTH from Date (characters 6-7)
stock$Month <- str_sub(stock$Date, 6, 7)

# Example C: Extract DAY from Date (characters 9-10)
stock$Day <- str_sub(stock$Date, 9, 10)

print("--- Extracted Year, Month, Day ---")
print(stock %>% select(Date, Year, Month, Day) %>% head())

# ==============================================================================
# 3. USING str_split() — Splitting Strings
# ==============================================================================

# Split Date into 3 parts using hyphen "-"
date_split <- str_split(stock$Date, "-", simplify = TRUE)

stock$Date_Year  <- date_split[, 1]
stock$Date_Month <- date_split[, 2]
stock$Date_Day   <- date_split[, 3]

print("--- Date Split into Year, Month, Day (using str_split) ---")
print(stock %>% select(Date, Date_Year, Date_Month, Date_Day) %>% head())

# Split Symbol into prefix & rest (if needed)
# Example: "MUNDRAPORT" → "MUNDRA" + "PORT"
symbol_split <- str_split(stock$Symbol, "(?<=.{6})", simplify = TRUE)

stock$Symbol_Prefix <- symbol_split[, 1]
stock$Symbol_Suffix <- symbol_split[, 2]

print("--- Symbol Split (Prefix/Suffix) ---")
print(stock %>% select(Symbol, Symbol_Prefix, Symbol_Suffix) %>% head())

# ==============================================================================
# 4. Bonus: Using separate() for splitting Date
# ==============================================================================

stock_separated <- stock %>% 
  separate(Date, into = c("sep_Year", "sep_Month", "sep_Day"), sep = "-")

print("--- Using separate(): Date Split into Columns ---")
print(stock_separated %>% select(sep_Year, sep_Month, sep_Day) %>% head())
