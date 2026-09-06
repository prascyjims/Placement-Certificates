# Telecom Customer Data Integration & Analytics Platform

A small telecom data engineering project using Azure Data Factory, ADLS Gen2, and Azure Databricks.

## Scope
- Parameterized ADF pipelines using Copy Activity, Lookup, ForEach, Get Metadata, and Triggers for SQL/CSV ingestion into ADLS Gen2 with incremental loading.
- Databricks notebooks and jobs using Apache Spark, PySpark, and Spark SQL for cleansing, joins, aggregations, deduplication, validation, and a simple business-rule transformation.
- Bronze, Silver, and Gold layers using Delta Lake with SCD Type 1 and Type 2 for the customer dimension.

The raw sample data contains multiple realistic quality issues for cleansing and validation.
