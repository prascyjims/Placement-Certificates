-- Analysis queries using cleaned customer records

-- Deduplicate customers before joining to orders
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
),
ValidOrderItems AS (
    SELECT *
    FROM order_items
    WHERE quantity > 0
      AND unit_price >= 0
)

-- 1. Customer sales using joins and aggregation
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM CleanCustomers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN ValidOrderItems oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_sales DESC;

-- 2. Customers whose sales are above the average customer sales
WITH CustomerSales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM CleanCustomers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN ValidOrderItems oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM CustomerSales
WHERE total_sales > (SELECT AVG(total_sales) FROM CustomerSales);

-- 3. Product sales using a CTE
WITH ProductSales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN ValidOrderItems oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM ProductSales
ORDER BY total_sales DESC;

-- 4. Rank products by sales using a window function
WITH ProductSales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN ValidOrderItems oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_id,
    product_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM ProductSales;

-- 5. Sales by customer city
SELECT
    c.city,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM CleanCustomers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN ValidOrderItems oi ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_sales DESC;
