DECLARE @WatermarkDate DATE='2026-06-20';
SELECT * FROM claims WHERE TRY_CONVERT(DATE,claim_date)>@WatermarkDate;
