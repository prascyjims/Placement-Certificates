SELECT plan_name,SUM(total_data_used_gb) AS total_data_used_gb,AVG(total_call_minutes) AS avg_call_minutes FROM gold_customer_usage GROUP BY plan_name;
SELECT usage_category,COUNT(*) AS customer_count FROM gold_customer_usage GROUP BY usage_category;
