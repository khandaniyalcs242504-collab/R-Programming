# ============================================================
# 7. Selecting and Dropping Variables using select() in R
# ============================================================

library(dplyr)

# 1. IMPORT DATASET
sales <- read.csv("sales_data - sales_data.csv")

print("--- Original Dataset (First 3 rows) ---")
print(head(sales, 3))

# ============================================================
# 2. SELECTING VARIABLES
# ============================================================

# A. Select specific columns
selected_cols <- sales %>%
  select(Product_ID, Sales_Rep, Sales_Amount)

print("--- Selected Specific Columns ---")
print(head(selected_cols, 3))


# B. Select a range of columns
# Example: Product_ID to Region
range_cols <- sales %>%
  select(Product_ID:Region)

print("--- Selected Range of Columns ---")
print(head(range_cols, 3))


# C. Select columns starting with "S"
starts_with_s <- sales %>%
  select(starts_with("S"))   # Sales_Amount, Sale_Date, Sales_Rep, Sales_Channel

print("--- Selected columns starting with 'S' ---")
print(head(starts_with_s, 3))

# ============================================================
# 3. DROPPING VARIABLES
# ============================================================

# A. Drop a single column
dropped_one <- sales %>%
  select(-Discount)

print("--- Dataset with 'Discount' dropped ---")
print(names(dropped_one))


# B. Drop multiple columns
dropped_multiple <- sales %>%
  select(-Unit_Cost, -Unit_Price)

print("--- Dropped 'Unit_Cost' and 'Unit_Price' ---")
print(names(dropped_multiple))


# C. Drop a range of columns
# Example: Drop Quantity_Sold to Customer_Type
dropped_range <- sales %>%
  select(-(Quantity_Sold:Customer_Type))

print("--- Dropped range 'Quantity_Sold' to 'Customer_Type' ---")
print(names(dropped_range))
