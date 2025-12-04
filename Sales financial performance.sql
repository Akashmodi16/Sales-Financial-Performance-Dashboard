CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;

-- CREATING THE TABLES
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
age INT,
gender VARCHAR(1),
register_date DATE 
);
-- CREATING PRODUCT TABLE
CREATE TABLE products (
product_id INT PRIMARY KEY,
category VARCHAR(50),
sub_category VARCHAR(50),
brand VARCHAR(50)
);
-- CREATING THE ORDER TABLE
CREATE TABLE orders (
order_id INT PRIMARY KEY,
order_date DATE,
customer_id INT,
product_id INT,
quantity INT,
selling_price DECIMAL(10,2),
cost_price DECIMAL(10,2),
discount DECIMAL(5,2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM customers;

-- Adding Revenue and profit column in orders
ALTER TABLE orders
ADD Column Revenue DECIMAL(10,2),
ADD Column profit DECIMAL(10,2);

UPDATE orders
SET
Revenue = selling_price * quantity,
profit = (selling_price - cost_price) * quantity;
-- These are going to be KPI's in dashboard as total_revenue, total_profit, and total_orders
SELECT
SUM(Revenue) AS total_revenue,
SUM(profit) AS total_profit,
COUNT(order_id) AS total_orders
FROM orders;

-- Monthly revenue trend is going to be line chart in excel
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(revenue) AS monthly_revenue,
    SUM(profit) AS monthly_profit
FROM orders
GROUP BY month
ORDER BY month;

-- Cotegory wise revenue is going to be Bar chart in excel so that we can analyze the revenue in monthly wise. 
SELECT 
    p.category,
    SUM(o.revenue) AS category_revenue,
    SUM(o.profit) AS category_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Gender wise Sales analyses.
SELECT 
    c.gender,
    SUM(o.revenue) AS revenue,
    SUM(o.profit) AS profit,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.gender;

-- Top 10 best selling product
SELECT 
    p.product_id,
    p.category,
    p.sub_category,
    SUM(o.quantity) AS units_sold,
    SUM(o.revenue) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.category, p.sub_category
ORDER BY units_sold DESC
LIMIT 10;

-- Sub cotegory analyses
SELECT 
    p.sub_category,
    SUM(o.revenue) AS revenue,
    SUM(o.profit) AS profit,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY revenue DESC;

-- Repeat customer analyses
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(revenue) AS total_revenue
FROM orders
GROUP BY customer_id
HAVING total_orders > 1
ORDER BY total_orders DESC;

-- City wise analysis
SELECT 
    c.city,
    SUM(o.revenue) AS city_revenue,
    SUM(o.profit) AS city_profit,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY city_revenue DESC;

-- Age wise analyze, useful for target audience insights
SELECT
    CASE 
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    SUM(o.revenue) AS revenue,
    SUM(o.profit) AS profit,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY age_group
ORDER BY revenue DESC;











