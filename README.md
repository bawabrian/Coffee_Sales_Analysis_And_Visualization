# ☕ Coffee Sales Analytics Dashboard
### *SQL · Excel · Pivot Tables · Data Visualisation · Business Intelligence*

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Excel](https://img.shields.io/badge/Microsoft%20Excel-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Complete-2ECC71?style=for-the-badge)
![Dataset](https://img.shields.io/badge/Dataset-Kaggle%20(Fictional)-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white)
![Data](https://img.shields.io/badge/Data-Fictional%20%7C%20Portfolio%20Only-lightgrey?style=for-the-badge)

---

> [!WARNING]
> **⚠️ DISCLAIMER — Please Read Before Using**
>
> - 📂 The dataset used in this project is **fictional** and was sourced from **Kaggle** for practice and learning purposes only.
> - 🏢 Any company names, customer names, and email addresses in the dataset are **entirely fictional** and do not represent real individuals or organisations.
> - 📊 All sales figures, quantities, and performance metrics are **simulated** and do **not represent real business data**.
> - 💼 This project is part of a **personal professional portfolio** and is intended solely to demonstrate practical **SQL data modelling, Excel pivot table analysis, and dashboard visualisation skills** in a realistic business context.

---

## 📸 Dashboard Preview

![Coffee Sales Dashboard](./Coffee_Dashboard.png)

> *An interactive Excel dashboard analysing simulated coffee sales across four coffee types, three countries, and four years (2019–2022) — built using SQL joins for data preparation and Excel pivot tables for dynamic analysis and visualisation.*

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Tech Stack & Workflow](#-tech-stack--workflow)
- [Key Metrics & Findings](#-key-metrics--findings)
- [SQL Data Model](#-sql-data-model)
- [Excel Workbook Structure](#-excel-workbook-structure)
- [Dashboard Features](#-dashboard-features)
- [Key Insights & Recommendations](#-key-insights--recommendations)
- [How to Use](#-how-to-use)
- [Project Structure](#-project-structure)
- [Disclaimer](#️-disclaimer)
- [Author](#-author)

---

## 🎯 Project Overview

This end-to-end data analytics project analyses **simulated coffee sales performance** across multiple dimensions — coffee type, roast type, bag size, country, loyalty card status, and customer behaviour — spanning four years from 2019 to 2022.

The project demonstrates a complete analyst workflow: **designing a multi-table relational database**, writing a **SQL JOIN query** to consolidate three raw tables into a single clean analytical view, importing that view into Excel, building **pivot tables** to slice the data, and assembling an **interactive dashboard** with slicers and a timeline filter.

### Three Source Tables → One Analytical View

A core focus of this project is the SQL data modelling step. Rather than working with a single flat file, the raw data arrives in three normalised tables — `orders`, `customers`, and `products` — and a SQL `CREATE TABLE ... AS SELECT` query with two `JOIN` operations is used to produce a denormalised summary table ready for Excel analysis.

### Business Questions Answered

| # | Question |
|---|----------|
| 1 | What is the total sales revenue across all years and coffee types? |
| 2 | How do sales trend month-by-month across 2019–2022? |
| 3 | Which coffee type (Arabica, Excelsa, Liberica, Robusta) generates the most revenue per year? |
| 4 | Which countries generate the most sales? |
| 5 | Who are the top 5 highest-spending customers? |
| 6 | Does loyalty card status correlate with higher customer spend? |
| 7 | Which roast type (Dark, Light, Medium) is most popular? |
| 8 | Which bag size (0.2 KG, 0.5 KG, 1 KG, 2.5 KG) drives most revenue? |

---

## 🛠️ Tech Stack & Workflow

```
THREE RAW TABLES (orders, customers, products)
              │
              ▼
      ┌──────────────┐
      │    MySQL     │  ── Single SQL JOIN query
      │   (Coffee.sql)│  ── Merges 3 tables into 1 analytical view
      └──────────────┘  ── Decodes abbreviated codes to full names
              │             (e.g. 'Rob' → 'Robusta', 'M' → 'Medium')
              ▼
  order_details_summary TABLE (16 columns, ready for analysis)
              │
              ▼
  ┌─────────────────────┐
  │  Microsoft Excel    │  ── 3 pivot tables (Sales, Country, Customers)
  │  (Workbook)         │  ── 3 interactive chart sheets
  └─────────────────────┘  ── 4 slicers + 1 timeline filter
              │
              ▼
  DASHBOARD (Excel)  ── Final stakeholder-ready deliverable
```

| Tool | Purpose |
|------|---------|
| **MySQL** | Database design, multi-table JOIN, column derivation, code decoding |
| **Microsoft Excel** | Pivot tables, charts, interactive dashboard, slicers |
| **Kaggle** | Source dataset (fictional coffee sales across 3 normalised tables) |

---

## 📊 Key Metrics & Findings

### Total Sales by Country

| Country | Total Sales (USD) |
|---------|------------------|
| 🇺🇸 **United States** | **$35,639** |
| 🇮🇪 Ireland | $6,697 |
| 🇬🇧 United Kingdom | $2,799 |
| **Grand Total** | **~$45,135** |

### Top 5 Customers by Spend

| Rank | Customer | Total Spend |
|------|----------|-------------|
| 1 | Allis Wilmore | $317 |
| 2 | Brenn Dundredge | $307 |
| 3 | Terri Farra | $289 |
| 4 | Nealson Cuttler | $282 |
| 5 | Don Flintiff | $278 |

### 🔑 Top Findings at a Glance

- **United States** dominates with **$35,639** in sales — 79% of total revenue, dwarfing Ireland ($6,697) and UK ($2,799) combined
- **2021 was the peak sales year** — Arabica ($3,500), Excelsa ($4,000), and Liberica ($3,800) all hit multi-year highs in 2021
- **Sales declined sharply in 2022** — all four coffee types dropped significantly, with partial-year data likely explaining the trend
- **Arabica and Excelsa** consistently lead annual revenues across all years
- **Liberica** showed the strongest 2021 spike but also the steepest subsequent drop
- The **top 5 customers** are tightly clustered in spend ($278–$317), suggesting no single dominant VIP customer

---

## 💾 SQL Data Model

### Database Schema

The raw data consists of three normalised relational tables:

```
┌──────────────┐         ┌──────────────────┐         ┌──────────────┐
│   orders     │         │    customers     │         │   products   │
│──────────────│         │──────────────────│         │──────────────│
│ Order_ID  PK │         │ Customer_ID   PK │         │ Product_ID PK│
│ Order_Date   │──────┐  │ Customer_Name    │  ┌──────│ Coffee_Type  │
│ Customer_ID  │──FK──┼──│ Email            │  │      │ Roast_Type   │
│ Product_ID   │──FK──┘  │ Country          │  │      │ Size         │
│ Quantity     │         │ Loyalty_Card     │  └──────│ Unit_Price   │
└──────────────┘         └──────────────────┘         └──────────────┘
```

### The Core SQL Query

The entire project's analysis rests on a single SQL `CREATE TABLE ... AS SELECT` statement that joins all three tables and performs three key transformations:

**1. Calculated column** — computes `Sales` from raw fields:
```sql
ROUND(o.Quantity * p.Unit_Price, 2) AS Sales
```

**2. Size formatting** — appends the unit label for readability:
```sql
CONCAT(p.size, ' KG') AS Size
```

**3. Code decoding** — expands abbreviated codes to human-readable names using `CASE` expressions:

```sql
CASE p.Coffee_Type
  WHEN 'Rob' THEN 'Robusta'
  WHEN 'Ara' THEN 'Arabica'
  WHEN 'Lib' THEN 'Liberica'
  WHEN 'Exc' THEN 'Excelsa'
  ELSE p.Coffee_Type
END AS Coffee_Type_Name,

CASE p.Roast_Type
  WHEN 'M' THEN 'Medium'
  WHEN 'D' THEN 'Dark'
  WHEN 'L' THEN 'Light'
  ELSE p.Roast_Type
END AS Roast_Type_Name
```

### Full SQL Script

```sql
USE coffee;

CREATE TABLE order_details_summary AS
SELECT
  o.Order_ID,
  o.Order_Date,
  o.Customer_ID,
  o.Product_ID,
  o.Quantity,
  c.Customer_Name,
  c.Email,
  c.Country,
  p.Coffee_Type,
  p.Roast_Type,
  CONCAT(p.size, ' KG') AS Size,
  p.Unit_Price,
  ROUND(o.Quantity * p.Unit_Price, 2) AS Sales,
  CASE p.Coffee_Type
    WHEN 'Rob' THEN 'Robusta'
    WHEN 'Ara' THEN 'Arabica'
    WHEN 'Lib' THEN 'Liberica'
    WHEN 'Exc' THEN 'Excelsa'
    ELSE p.Coffee_Type
  END AS Coffee_Type_Name,
  CASE p.Roast_Type
    WHEN 'M' THEN 'Medium'
    WHEN 'D' THEN 'Dark'
    WHEN 'L' THEN 'Light'
    ELSE p.Roast_Type
  END AS Roast_Type_Name,
  c.Loyalty_Card
FROM orders o
JOIN customers c ON o.Customer_ID = c.Customer_ID
JOIN products p  ON o.Product_ID  = p.Product_ID;
```

### Output Table — `order_details_summary`

The resulting table has **16 columns**, combining fields from all three source tables:

| Column | Source Table | Description |
|--------|-------------|-------------|
| `Order_ID` | orders | Unique order identifier |
| `Order_Date` | orders | Date the order was placed |
| `Customer_ID` | orders | Foreign key to customers |
| `Product_ID` | orders | Foreign key to products |
| `Quantity` | orders | Number of units ordered |
| `Customer_Name` | customers | Full name of the customer |
| `Email` | customers | Customer email address |
| `Country` | customers | Customer country |
| `Coffee_Type` | products | Abbreviated coffee type (Ara, Rob, etc.) |
| `Roast_Type` | products | Abbreviated roast type (M, D, L) |
| `Size` | products | Bag size with KG label (e.g. "1 KG") |
| `Unit_Price` | products | Price per unit |
| `Sales` | **Derived** | `Quantity × Unit_Price` (calculated) |
| `Coffee_Type_Name` | **Derived** | Full coffee type name (e.g. "Arabica") |
| `Roast_Type_Name` | **Derived** | Full roast name (e.g. "Medium") |
| `Loyalty_Card` | customers | Whether customer holds a loyalty card (Yes/No) |

---

## 📒 Excel Workbook Structure

The workbook (`Coffee_Sales_Project.xlsx`) contains **5 sheets**:

| Sheet | Contents |
|-------|---------|
| **Order_Details_Summary** | The full analytical table exported from SQL — 16 columns, all order records from 2019–2022 |
| **Total Sales** | Pivot table: Sales by Year, Month, and Coffee Type (4 coffee types as columns) |
| **Country** | Pivot table: Total Sales summed by Country (3 countries) |
| **Top Customers** | Pivot table: Top 5 customers ranked by total spend |
| **Dashboard** | Final interactive dashboard combining all three pivot charts with slicers and a timeline |

### Pivot Tables Built

| Sheet | Row Field | Column Field | Value | Purpose |
|-------|-----------|-------------|-------|---------|
| **Total Sales** | `Order_Date` (year + month) | `Coffee_Type_Name` | SUM of `Sales` | Time series chart by coffee type |
| **Country** | `Country` | — | SUM of `Sales` | Country bar chart |
| **Top Customers** | `Customer_Name` (top 5) | — | SUM of `Sales` | Top customers bar chart |

---

## ✨ Dashboard Features

The dashboard is laid out in a **2×2 grid** below a filter bar at the top. All three charts respond simultaneously to all four slicers and the timeline filter.

### 📌 Top Panel — Filters Bar

Five interactive filters sit across the top of the dashboard, each connected to all pivot tables:

| Filter | Type | Options |
|--------|------|---------|
| **Order_Date** | Timeline Slicer | Jan 2019 – Dec 2022, filterable by month |
| **Roast_Type_Name** | Slicer | Dark · Light · Medium |
| **Size** | Slicer | 0.2 KG · 0.5 KG · 1 KG · 2.5 KG |
| **Loyalty_Card** | Slicer | Yes · No |

> All four filters operate simultaneously. Selecting "Loyalty_Card = Yes" + "Size = 1 KG" will instantly update all three charts to show only loyalty card holders purchasing 1 KG bags.

---

### 📈 Visual Panels

#### Panel 1 — Total Sales Over Time (Clustered Bar Chart)
A grouped bar chart showing annual sales for each of the four coffee types, with years on the X-axis (2019–2022):

| Year | Arabica | Excelsa | Liberica | Robusta |
|------|---------|---------|----------|---------|
| 2019 | $2,927 | $3,481 | $3,378 | $2,401 |
| 2020 | $3,433 | $2,556 | $2,536 | $2,498 |
| 2021 | $3,480 | $4,006 | $3,814 | $2,427 |
| 2022 | $1,468 | $1,580 | $2,193 | $1,619 |

> The 2022 dip is visible across all coffee types and is likely due to partial-year data coverage rather than a genuine sales decline.

#### Panel 2 — Sales by Country (Horizontal Bar Chart)
A horizontal bar chart ranking the three markets by total revenue:

| Country | Total Sales |
|---------|------------|
| 🇺🇸 United States | **$35,639** |
| 🇮🇪 Ireland | $6,697 |
| 🇬🇧 United Kingdom | $2,799 |

The US market is disproportionately large — nearly 79% of all revenue comes from a single country.

#### Panel 3 — Top 5 Customers (Horizontal Bar Chart)
A horizontal bar chart showing the five highest-spending individual customers:

| Rank | Customer | Spend |
|------|----------|-------|
| 1 | Allis Wilmore | $317 |
| 2 | Brenn Dundredge | $307 |
| 3 | Terri Farra | $289 |
| 4 | Nealson Cuttler | $282 |
| 5 | Don Flintiff | $278 |

---

## 💡 Key Insights & Recommendations

> 📌 The following insights are analytical exercises drawn from a **fictional dataset** and are not real business recommendations.

### 1. 🇺🇸 The US Market Is Dominant — But Concentrated Risk
The United States accounts for **79% of total revenue ($35,639)**. While strong, this level of geographic concentration is a business risk. Expanding Ireland ($6,697) and UK ($2,799) operations — or entering new markets — would build resilience.

### 2. 📈 2021 Was the Peak Year — Understand Why
All four coffee types hit their highest revenue in 2021. Understanding the drivers behind this peak (promotions, new customers, product launches) is essential for replicating the conditions that produced it.

### 3. ☕ Arabica & Excelsa Are the Revenue Engines
Arabica and Excelsa consistently rank as the top two revenue generators across all years. Marketing spend and stock priority should protect these two lines, as any disruption would have an outsized revenue impact.

### 4. 🎯 Liberica Has the Highest Volatility
Liberica showed the strongest single-year spike in 2021 ($3,814) but also a steep drop. Investigating whether this was driven by a seasonal campaign or a specific customer cohort would help smooth future performance.

### 5. 🃏 Loyalty Card Analysis Is a Hidden Insight
The dashboard's Loyalty_Card slicer lets you instantly compare spend between loyalty holders and non-holders. Running this filter can reveal whether the loyalty programme is successfully increasing average order value — a key retention metric.

### 6. 🎒 Bag Size Preference Data Is Available
The Size slicer (0.2 KG, 0.5 KG, 1 KG, 2.5 KG) provides packaging preference insights. If 1 KG bags consistently generate the most revenue, production and procurement should be optimised toward that format.

---

## 🚀 How to Use

### Prerequisites
- [MySQL Community Server](https://dev.mysql.com/downloads/) — version 8.x recommended
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) or any SQL client
- Microsoft Excel 2016 or later (pivot tables, slicers, and timeline slicer required)

### Step 1 — Set Up the Database

```sql
-- Create the database
CREATE DATABASE coffee;
USE coffee;

-- Create and populate the three raw tables:
-- orders, customers, products
-- (Load from the Kaggle CSV source files)

-- Then run the JOIN script to create the analytical view
SOURCE Coffee.sql;
```

### Step 2 — Verify the Output Table

```sql
-- Confirm the table was created correctly
SELECT * FROM order_details_summary LIMIT 10;

-- Check column count and row count
SELECT COUNT(*) FROM order_details_summary;
DESCRIBE order_details_summary;
```

### Step 3 — Open the Excel Workbook

```
1. Open Coffee_Sales_Project.xlsx in Microsoft Excel
2. Navigate to the Dashboard sheet (first tab)
3. Use the Order_Date timeline to filter by date range
4. Use the Roast_Type_Name slicer to filter by roast
5. Use the Size slicer to filter by bag size
6. Use the Loyalty_Card slicer to compare loyalty vs non-loyalty customers
7. All three charts will update simultaneously when any filter is applied
```

### Step 4 — Clone This Repository

```bash
# Clone the repository
git clone https://github.com/bawabrian/coffee-sales-dashboard.git

# Navigate to the project folder
cd coffee-sales-dashboard
```

---

## 📁 Project Structure

```
coffee-sales-dashboard/
│
├── 📄 README.md                        # This file
├── 💾 Coffee.sql                       # SQL JOIN script — creates order_details_summary
├── 📊 Coffee_Sales_Project.xlsx        # Excel workbook with pivot tables & dashboard
├── 📸 Coffee_Dashboard_.png            # Dashboard screenshot (preview image)
└── 📁 data/
    ├── orders.csv                      # Raw orders table (Kaggle — fictional)
    ├── customers.csv                   # Raw customers table (Kaggle — fictional)
    └── products.csv                    # Raw products table (Kaggle — fictional)
```

---

## ⚠️ Disclaimer

This project is a **personal portfolio piece** built for learning and skill demonstration purposes only.

| | |
|---|---|
| 📂 **Dataset** | Fictional coffee sales dataset sourced from [Kaggle](https://www.kaggle.com). This is **not** real transactional data from any company. |
| 👤 **Customer Data** | All customer names and email addresses in the dataset are **entirely fictional** and do not represent real individuals. |
| 📊 **Figures & Metrics** | All sales figures, quantities, and performance metrics are **simulated**. They do not represent the actual performance of any business. |
| 💼 **Intent** | This project exists solely to showcase **SQL data modelling (multi-table JOINs), Excel pivot table analysis, slicer-based interactivity, and business dashboard design skills** in a realistic context. |
---

## 📬 Author

**Brian Bawa**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/brian-bawa/)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/bawabrian)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:brianbawa@gmail.com)

---

<div align="center">

⭐ **If you found this project useful, please give it a star!** ⭐

*Built with ☕ using MySQL & Excel · Dataset from Kaggle · Portfolio Project Only*

</div>
