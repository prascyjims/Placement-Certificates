-- Reusable views for reporting

CREATE VIEW vw_customer_sales AS
WITH CleanCustomers AS (
    SELECT customer_id, customer_name, email, city
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY customer_id
                   ORDER BY customer_id
               ) AS rn
        FROM customers
    ) x
    WHERE rn = 1
)
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM CleanCustomers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.quantity > 0
  AND oi.unit_price >= 0
GROUP BY c.customer_id, c.customer_name;
GO

CREATE VIEW vw_product_sales AS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.quantity > 0
  AND oi.unit_price >= 0
GROUP BY p.product_id, p.product_name;
GO
