# ============================================================
# Agricultural Produce Data Analysis
# Author: Setso Malabola (2332781)
# Date: November 2024
# ============================================================

# ---- 1. Load Libraries ----
library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

# ---- 2. Load Dataset ----
agricultural_data <- read_csv("agricultural_data.csv")
View(agricultural_data)

# ---- 3. Data Cleaning ----

# Check for missing values
missing_values <- agricultural_data %>%
  summarise_all(~ sum(is.na(.)))
print("Missing Values per Column:")
print(missing_values)

# Remove rows with missing values
agricultural_data_clean <- agricultural_data %>%
  drop_na(Crop_Name, Region, Production_Quantity, Price_Per_Unit, Harvest_Season, Year)

print(paste("Rows before cleaning:", nrow(agricultural_data)))
print(paste("Rows after cleaning:", nrow(agricultural_data_clean)))

# ---- 4. Descriptive Statistics ----
cat("\n--- Dataset Structure ---\n")
str(agricultural_data_clean)

cat("\n--- Summary Statistics ---\n")
summary(agricultural_data_clean)

cat("\n--- Production & Price Summary ---\n")
summary(agricultural_data_clean[, c("Production_Quantity", "Price_Per_Unit")])

# ---- 5. Crop-level Summary ----
crop_summary <- agricultural_data_clean %>%
  group_by(Crop_Name) %>%
  summarise(
    total_production  = sum(Production_Quantity, na.rm = TRUE),
    avg_production    = mean(Production_Quantity, na.rm = TRUE),
    median_production = median(Production_Quantity, na.rm = TRUE)
  )
print("Crop Summary:")
print(crop_summary)

# ---- 6. Most Productive Crops ----
most_productive_crops <- agricultural_data_clean %>%
  group_by(Crop_Name) %>%
  summarise(total_production = sum(Production_Quantity, na.rm = TRUE)) %>%
  arrange(desc(total_production))
print("Most Productive Crops:")
print(most_productive_crops)

# ---- 7. Most Productive Regions ----
most_productive_region <- agricultural_data_clean %>%
  group_by(Region) %>%
  summarise(total_production = sum(Production_Quantity, na.rm = TRUE)) %>%
  arrange(desc(total_production))
print("Most Productive Regions:")
print(most_productive_region)

# ---- 8. Harvest Season Summary ----
season_summary <- agricultural_data_clean %>%
  group_by(Harvest_Season) %>%
  summarize(
    Total_Production = sum(Production_Quantity, na.rm = TRUE),
    Average_Price    = mean(Price_Per_Unit, na.rm = TRUE)
  )
print("Summary by Harvest Season:")
print(season_summary)

# ---- 9. Visualisations ----

# 9a. Production Quantity by Crop
crop_production <- agricultural_data_clean %>%
  group_by(Crop_Name) %>%
  summarise(total_production = sum(Production_Quantity, na.rm = TRUE))

ggplot(crop_production, aes(x = reorder(Crop_Name, -total_production), y = total_production)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(
    title = "Production Quantity by Crop",
    x     = "Crop Name",
    y     = "Total Production Quantity"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 9b. Total Production by Region
region_production <- agricultural_data_clean %>%
  group_by(Region) %>%
  summarise(total_production = sum(Production_Quantity, na.rm = TRUE))

ggplot(region_production, aes(x = reorder(Region, -total_production), y = total_production)) +
  geom_bar(stat = "identity", fill = "pink") +
  labs(
    title = "Total Production Quantity by Region",
    x     = "Region",
    y     = "Total Production Quantity"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 9c. Price vs Production Quantity (Scatter)
ggplot(agricultural_data_clean, aes(x = Production_Quantity, y = Price_Per_Unit)) +
  geom_point(color = "darkgreen", size = 3, alpha = 0.6) +
  labs(
    title = "Price vs. Production Quantity",
    x     = "Production Quantity",
    y     = "Price per Unit"
  ) +
  theme_minimal()

# 9d. Total Production by Harvest Season
ggplot(agricultural_data_clean, aes(x = Harvest_Season, y = Production_Quantity, fill = Harvest_Season)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(
    title  = "Total Production by Harvest Season",
    x      = "Harvest Season",
    y      = "Total Production"
  ) +
  theme(legend.position = "none")

# 9e. Average Price by Harvest Season
ggplot(agricultural_data_clean, aes(x = Harvest_Season, y = Price_Per_Unit, fill = Harvest_Season)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  labs(
    title  = "Average Price by Harvest Season",
    x      = "Harvest Season",
    y      = "Average Price per Unit"
  ) +
  theme(legend.position = "none")

# ---- 10. Price Prediction (Linear Regression) ----
model <- lm(Price_Per_Unit ~ Production_Quantity, data = agricultural_data_clean)
cat("\n--- Linear Regression: Price_Per_Unit ~ Production_Quantity ---\n")
summary(model)

# Plot regression line
ggplot(agricultural_data_clean, aes(x = Production_Quantity, y = Price_Per_Unit)) +
  geom_point(color = "darkgreen", size = 3, alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(
    title = "Price Prediction Based on Production Quantity",
    x     = "Production Quantity",
    y     = "Price per Unit"
  ) +
  theme_minimal()
