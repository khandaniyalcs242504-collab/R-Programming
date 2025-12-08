# ==============================================================================
# R Script: Vertical Concatenation using rbind()
# Datasets: 'mtcars' (Built-in) and 'customer_shopping_data.csv' (Custom)
# ==============================================================================

# ==============================================================================
# 1. SETUP: Create and Import Data
# ==============================================================================

# Load built-in dataset
data(mtcars)
mtcars$RecordID <- rownames(mtcars)
rownames(mtcars) <- NULL

# Load your customer shopping dataset
shop_df <- read.csv("customer_shopping_data.csv", na.strings = c("", "NA"))

print("--- Data Structure Before Transformation ---")
print(names(mtcars))
print(names(shop_df))

# ==============================================================================
# 2. DATA PREPARATION (AUTO COLUMN ALIGNMENT)
# ==============================================================================

# Find COMMON columns between both datasets
common_cols <- intersect(names(mtcars), names(shop_df))

print("--- Common Columns Used for rbind() ---")
print(common_cols)

# Keep only common columns
mtcars_clean <- mtcars[, common_cols, drop = FALSE]
shop_clean   <- shop_df[, common_cols, drop = FALSE]

# ==============================================================================
# 3. VERTICAL COMBINATION (rbind)
# ==============================================================================

combined_data <- rbind(mtcars_clean, shop_clean)

print("--- Combined Data Summary ---")
print(paste("mtcars rows:", nrow(mtcars_clean)))
print(paste("Shopping rows:", nrow(shop_clean)))
print(paste("Total rows (Expected):", nrow(mtcars_clean) + nrow(shop_clean)))
print(paste("Total rows (Actual):", nrow(combined_data)))

print("--- Preview of Combined Data (Top and Bottom) ---")
print(head(combined_data))
print(tail(combined_data))
