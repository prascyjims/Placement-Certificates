-- Incremental load using the last processed transaction date

DECLARE @WatermarkDate DATE = '2026-08-07';

SELECT
    transaction_id,
    account_id,
    customer_id,
    transaction_date,
    transaction_type,
    amount
FROM transactions
WHERE TRY_CONVERT(DATE, transaction_date) > @WatermarkDate;
