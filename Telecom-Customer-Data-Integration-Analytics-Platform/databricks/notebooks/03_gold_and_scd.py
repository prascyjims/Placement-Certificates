# Create Gold data and simple SCD Type 1/Type 2 customer dimension examples.
from pyspark.sql import functions as F
silver=spark.read.format("delta").load("/mnt/telecom/silver/customer_usage")
gold=silver.select("customer_id","customer_name","plan_name","city","monthly_fee","total_data_used_gb","total_call_minutes","usage_category")
gold.write.format("delta").mode("overwrite").save("/mnt/telecom/gold/customer_usage")
# SCD Type 1: latest customer value only.
scd1=gold.select("customer_id","customer_name","plan_name","city")
# SCD Type 2: retain versions with effective dates and current flag.
scd2=gold.withColumn("effective_start_date",F.current_date()).withColumn("effective_end_date",F.lit(None).cast("date")).withColumn("is_current",F.lit(True))
scd2.write.format("delta").mode("overwrite").save("/mnt/telecom/gold/customer_dimension_scd2")
