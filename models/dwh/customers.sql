{{ config(materialized='table', schema='OMMART_DWH') }}
select * from {{ ref('stg_customers') }}