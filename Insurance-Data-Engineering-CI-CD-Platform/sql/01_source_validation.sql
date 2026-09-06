SELECT * FROM customers;
SELECT * FROM policies;
SELECT * FROM claims;
SELECT customer_id,COUNT(*) AS duplicate_count FROM customers GROUP BY customer_id HAVING COUNT(*)>1;
SELECT * FROM customers WHERE policy_type NOT IN ('Health','Auto','Life') OR city IS NULL;
SELECT * FROM policies WHERE customer_id NOT IN (SELECT customer_id FROM customers) OR coverage_amount<=0 OR policy_start_date IS NULL;
SELECT * FROM claims WHERE policy_id NOT IN (SELECT policy_id FROM policies) OR claim_amount<=0 OR claim_date IS NULL;
