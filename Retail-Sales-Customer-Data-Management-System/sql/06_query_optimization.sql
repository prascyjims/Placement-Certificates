-- Basic query-performance review in SQL Server

-- In SSMS, enable the Actual Execution Plan with Ctrl+M
-- and compare the plan before and after adding useful indexes.

-- Query to review
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
  AND o.order_date >= '2026-08-01'
  AND o.order_date < '2026-09-01'
  AND oi.quantity > 0
  AND oi.unit_price >= 0
GROUP BY c.customer_id, c.customer_name;

-- Example indexes to support common joins and filters
CREATE INDEX IX_orders_customer_status_date
ON orders(customer_id, status, order_date);

CREATE INDEX IX_order_items_order
ON order_items(order_id);

-- Review the execution plan after index creation.
-- On a small sample dataset, the purpose is to demonstrate
-- the process rather than claim a large measured speed-up.
