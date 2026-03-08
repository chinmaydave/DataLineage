{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='"shipment_id"',
    on_schema_change='sync_all_columns'
) }}

select *
from PC_FIVETRAN_DB."dbo"."shipments"
where coalesce("_fivetran_deleted", false) = false

{% if is_incremental() %}
  and "_fivetran_synced" > (
      select coalesce(max("_fivetran_synced"), '1900-01-01'::timestamp_tz)
      from {{ this }}
  )
{% endif %}