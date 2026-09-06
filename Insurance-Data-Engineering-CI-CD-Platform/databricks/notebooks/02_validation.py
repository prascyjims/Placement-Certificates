from pyspark.sql import functions as F
gold=spark.read.format("delta").load("/mnt/insurance/gold/claims")
gold.groupBy("claim_risk").count().show()
gold.groupBy("policy_type").agg(F.sum("claim_amount").alias("total_claims")).show()
