# Read SQL/CSV data and store raw data as Delta in Bronze.
from pyspark.sql import functions as F
customers=spark.read.option("header",True).csv("/mnt/telecom/raw/customers.csv")
plans=spark.read.option("header",True).csv("/mnt/telecom/raw/plans.csv")
usage=spark.read.option("header",True).csv("/mnt/telecom/raw/usage.csv")
customers.write.format("delta").mode("overwrite").save("/mnt/telecom/bronze/customers")
plans.write.format("delta").mode("overwrite").save("/mnt/telecom/bronze/plans")
usage.write.format("delta").mode("overwrite").save("/mnt/telecom/bronze/usage")
