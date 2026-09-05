-- Identify and handle common data-quality issues

-- 1. Find duplicate customer records
SELECT customer_id, COUNT(*) AS record_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Keep one customer record for each customer_id
WITH ranked_customers AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY customer_id
           ) AS rn
    FROM customers
)
SELECT customer_id, customer_name, email, city
FROM ranked_customers
WHERE rn = 1;

-- 2. Find customers with missing email values
SELECT *
FROM customers
WHERE NULLIF(LTRIM(RTRIM(email)), '') IS NULL;

-- 3. Find invalid order items
SELECT *
FROM order_items
WHERE quantity <= 0
   OR unit_price < 0;

-- Example of retaining only valid order items
SELECT *
FROM order_items
WHERE quantity > 0
  AND unit_price >= 0;

-- 4. Find orders whose customer_id does not exist
SELECT o.*
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
