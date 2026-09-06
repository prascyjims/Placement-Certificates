# Clean, validate, deduplicate, join, aggregate, and apply a business rule.
from pyspark.sql import functions as F
from pyspark.sql.window import Window
customers=spark.read.format("delta").load("/mnt/telecom/bronze/customers")
plans=spark.read.format("delta").load("/mnt/telecom/bronze/plans")
usage=spark.read.format("delta").load("/mnt/telecom/bronze/usage")
w=Window.partitionBy("customer_id").orderBy("customer_id")
customers_clean=customers.withColumn("rn",F.row_number().over(w)).filter("rn=1").drop("rn")
customers_clean=customers_clean.filter(F.col("customer_name").isNotNull() & F.col("plan_name").isin("Basic","Premium","Family"))
usage_clean=usage.withColumn("usage_date",F.to_date("usage_date")).filter(F.col("usage_date").isNotNull()).filter(F.col("data_used_gb")>=0).dropDuplicates(["usage_id"])
usage_clean=usage_clean.join(customers_clean.select("customer_id"),"customer_id","inner")
customer_plan=customers_clean.join(plans,"plan_name","left")
usage_summary=usage_clean.groupBy("customer_id").agg(F.sum("data_used_gb").alias("total_data_used_gb"),F.sum("call_minutes").alias("total_call_minutes"))
result=customer_plan.join(usage_summary,"customer_id","left")
result=result.withColumn("usage_category",F.when(F.col("total_data_used_gb")>50,"Heavy User").otherwise("Regular User"))
result.write.format("delta").mode("overwrite").save("/mnt/telecom/silver/customer_usage")
