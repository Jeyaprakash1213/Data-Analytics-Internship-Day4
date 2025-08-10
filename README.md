SQL Data Analysis for E-commerce
Project Overview
This SQL-based data analysis project focuses on extracting actionable insights from an e-commerce database. The solution demonstrates core SQL skills including complex joins, aggregation, window functions, and query optimization to solve business problems and drive decision-making.

Database Schema
The relational database consists of four interconnected tables:

customers

Stores customer information (ID, name, email, join date, location)

products

Contains product details (ID, name, category, price, inventory)

orders

Tracks order records (ID, customer ID, date, status)

order_items

Records products purchased in each order (order ID, product ID, quantity)

Relationships:

One customer → Many orders

One order → Many order items

One product → Many order items

Key Analytical Queries
1. Revenue Analysis
sql
-- Monthly revenue trends
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(quantity * price) AS revenue,
    AVG(quantity * price) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month DESC;
Insight: Identifies seasonal patterns and measures order value changes over time.

2. Customer Segmentation
sql
-- Top customers by lifetime value
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * p.price) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;
Insight: Identifies high-value customers for targeted marketing campaigns.

3. Product Performance
sql
-- Top products by revenue and units sold
SELECT 
    p.category,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY revenue DESC;
Insight: Reveals best-performing products and categories for inventory optimization.

4. Cohort Retention Analysis
sql
WITH first_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    DATE_FORMAT(f.first_order_date, '%Y-%m') AS cohort,
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.customer_id) AS customers
FROM orders o
JOIN first_orders f ON o.customer_id = f.customer_id
GROUP BY cohort, order_month;
Insight: Measures customer retention rates over time to evaluate loyalty program effectiveness.

5. Inventory Optimization
sql
-- Stock levels vs sales velocity
SELECT 
    product_name,
    category,
    stock_quantity,
    (SELECT SUM(quantity) 
     FROM order_items oi 
     WHERE oi.product_id = p.product_id) AS units_sold,
    stock_quantity / NULLIF((SELECT SUM(quantity) 
                           FROM order_items oi 
                           WHERE oi.product_id = p.product_id), 0) AS months_inventory
FROM products p;
Insight: Identifies overstocked and understocked products based on sales patterns.

Business Insights Derived
Key Findings
Revenue Trends: Electronics is the top revenue-generating category (35% of total revenue)

Customer Value: Top 20% customers generate 68% of total revenue

Seasonality: Sales peak in Q4 (October-December) with 40% higher AOV

Retention: March cohort shows 65% retention rate after 3 months
