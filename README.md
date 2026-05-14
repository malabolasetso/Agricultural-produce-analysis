# Agricultural Produce Data Analysis Using R

**Student:** Setso Malabola (2332781)  
**Course:** Final Exam — Agricultural Data Analysis  
**Date:** November 2024

---

## Project Overview

This project analyses a dataset of 100 agricultural produce records using R programming. The analysis covers data cleaning, descriptive statistics, data visualisation, and predictive modelling to uncover production trends and price patterns across various crops and regions.

---

## Dataset

**File:** `agricultural_data.csv`

| Column | Description |
|---|---|
| `Crop_Name` | Name of the crop (e.g., Wheat, Rice, Corn) |
| `Region` | Geographic region (North, South, East, West, Central) |
| `Production_Quantity` | Volume of crop produced |
| `Price_Per_Unit` | Market price per unit |
| `Harvest_Season` | Season of harvest (Spring, Summer, Fall, Winter) |
| `Year` | Year of production |

---

## Project Structure

```
agricultural-produce-analysis/
│
├── agricultural_analysis.R   # Main R analysis script
├── agricultural_data.csv     # Dataset (100 rows)
└── README.md                 # Project documentation
```

---

## Analysis Steps

### 1. Data Loading & Cleaning
- Load the CSV using `readr::read_csv()`
- Detect and report missing values per column
- Remove incomplete rows using `drop_na()`

### 2. Descriptive Statistics
- Dataset structure with `str()`
- Full summary with `summary()`
- Per-column statistics for `Production_Quantity` and `Price_Per_Unit`

### 3. Visualisation
- **Bar chart** — Total production quantity by crop
- **Bar chart** — Total production quantity by region
- **Scatter plot** — Price vs. production quantity
- **Bar chart** — Total production by harvest season
- **Bar chart** — Average price by harvest season
- **Regression plot** — Predicted price trend over production quantity

### 4. Most Productive Crops & Regions
- Grouped summaries using `dplyr`
- Ranked by total production in descending order

### 5. Price Prediction (Linear Regression)
- Model: `Price_Per_Unit ~ Production_Quantity`
- Built using `lm()`
- Summary output includes R², coefficients, and p-values

---

## How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/agricultural-produce-analysis.git
   cd agricultural-produce-analysis
   ```

2. **Open R or RStudio**

3. **Install required packages** (first time only)
   ```r
   install.packages(c("tidyverse", "ggplot2", "dplyr", "tidyr", "readr"))
   ```

4. **Run the analysis script**
   ```r
   source("agricultural_analysis.R")
   ```

---

## Requirements

- R version 4.0 or higher
- Packages: `tidyverse`, `ggplot2`, `dplyr`, `tidyr`, `readr`

---

## Key Findings

- Production quantities and prices vary significantly across crops and regions.
- Seasonal patterns affect both total production volume and average market price.
- A linear regression model is used to explore the relationship between production quantity and price per unit.

---

## License

This project was submitted as academic coursework. Please do not copy or submit as your own work.
