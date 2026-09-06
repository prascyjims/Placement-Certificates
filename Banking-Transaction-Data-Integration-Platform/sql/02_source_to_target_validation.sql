-- Source-to-target validation

SELECT COUNT(*) AS source_customer_count FROM customers;
SELECT COUNT(*) AS source_account_count FROM accounts;
SELECT COUNT(*) AS source_transaction_count FROM transactions;

-- Basic duplicate check for transaction IDs
SELECT transaction_id, COUNT(*) AS record_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;
