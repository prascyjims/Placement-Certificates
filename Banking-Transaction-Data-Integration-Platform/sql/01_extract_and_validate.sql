-- Extract source data and perform basic validation

SELECT * FROM customers;
SELECT * FROM customers
WHERE NULLIF(LTRIM(RTRIM(email)), '') IS NULL;

SELECT * FROM accounts;
SELECT * FROM accounts WHERE balance < 0;

SELECT a.*
FROM accounts a
LEFT JOIN customers c ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT * FROM transactions;
SELECT * FROM transactions
WHERE amount <= 0
   OR NULLIF(LTRIM(RTRIM(transaction_date)), '') IS NULL;

SELECT t.*
FROM transactions t
LEFT JOIN accounts a ON t.account_id = a.account_id
WHERE a.account_id IS NULL;
