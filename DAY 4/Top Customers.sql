SELECT 
    c.name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(oi.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;