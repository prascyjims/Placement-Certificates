# Banking Transaction Data Integration Platform

## Overview
A small banking data integration project using SQL Server, Azure Data Factory (ADF), and ADLS Gen2.

## Scope
- Developed SQL queries to extract customer, account, and transaction data from source tables.
- Performed basic data validation before loading.
- Used ADF pipelines to move SQL Server and CSV data to ADLS Gen2.
- Used Copy Activity, Lookup, ForEach, and parameterized datasets.
- Used a transaction date/watermark column for incremental loading to avoid reprocessing.
- Performed source-to-target validation and basic pipeline monitoring.
- Used a simple failure path for a failed Copy Activity and verified successful data movement.

## GitHub Proof
The `adf` folder contains ADF-style JSON definitions for the pipeline activities and parameterized datasets used in this project. They are intentionally kept small and readable.
