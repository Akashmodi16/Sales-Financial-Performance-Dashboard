# 📊 Sales & Financial Performance Dashboard (Power BI + MySQL)

This project is a complete end-to-end data analytics solution built using **MySQL** for data processing and **Power BI** for interactive visualization.  
The dashboard provides insights into **revenue**, **sales performance**, **profitability**, and **financial contribution analysis**.

---

## 🚀 Project Overview

This dashboard answers key business questions:

- Which cities generate the highest revenue?
- How do product categories contribute to total sales?
- What is the monthly revenue & profit margin trend?
- How does revenue flow into net profit (Revenue → COGS → GP → EBIT → Net Profit)?
- What financial KPIs summarize the business performance?

The solution demonstrates skills in **SQL**, **data modeling**, **DAX**, **financial analytics**, and **dashboard design**.

---

## 🖼 Dashboard Preview

### 📍 Full Dashboard  
*(Replace this image with your real screenshot after upload)*  
![Dashboard Screenshot](screenshots/dashboard_full.png)

---

## 🧩 Dashboard Sections

### 🔹 1. Filters  
Interactive slicer to filter insights by major cities.

### 🔹 2. KPI Indicators  
- **Total Revenue**  
- **Total Sales**  
- **Average Order Value**  
- **Gross Profit**  

![KPIs](screenshots/kpis.png)

---

### 🔹 3. Revenue by Category  
A horizontal bar chart comparing category-wise performance.

![Category Chart](screenshots/category_chart.png)

---

### 🔹 4. Monthly Revenue & Profit Margin (%)  
Combo chart showing revenue bars with margin line trend.

![Combo Chart](screenshots/combo_chart.png)

---

### 🔹 5. Revenue to Net Profit Bridge (Waterfall Chart)  
Financial breakdown showing contribution of COGS, Opex, Interest & Tax, and Net Profit.

![Waterfall Chart](screenshots/waterfall_chart.png)

---

## 🛠 Tools & Technologies

| Component | Technology Used |
|----------|-----------------|
| Database | MySQL |
| Query Language | SQL |
| Visualization | Power BI Desktop |
| Data Modeling | Star Schema + DAX |
| File Format | PBIX |

---

## 🗄 SQL Queries Used

The dataset was stored in MySQL and queried using SQL before loading into Power BI.  
Below are the main queries used:

```sql
-- Revenue by City
SELECT 
    c.city,
    SUM(o.revenue) AS total_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Revenue by Category
SELECT 
    p.category,
    SUM(o.revenue) AS category_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Monthly Revenue Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(revenue) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- Top 5 Products by Revenue
SELECT 
    p.product_name,
    p.category,
    SUM(o.revenue) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;

