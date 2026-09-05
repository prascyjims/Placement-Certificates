-- Reusable stored procedure for customer sales

CREATE PROCEDURE usp_GetCustomerSales
    @CustomerId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    WITH CleanCustomers AS (
        SELECT customer_id, customer_name
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
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE oi.quantity > 0
      AND oi.unit_price >= 0
      AND (@CustomerId IS NULL OR c.customer_id = @CustomerId)
    GROUP BY c.customer_id, c.customer_name;
END;
GO

-- Examples:
-- EXEC usp_GetCustomerSales;
-- EXEC usp_GetCustomerSales @CustomerId = 101;
