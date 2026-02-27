{{ config(materialized='table') }}
select * from PC_FIVETRAN_DB."dbo"."order_items"