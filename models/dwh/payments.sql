{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='"payment_id"',
    schema='OMMART_DWH',
    on_schema_change='sync_all_columns'
) }}

select *
from {{ ref('stg_payments') }}

{% if is_incremental() %}
where "_fivetran_synced" > (
    select coalesce(max("_fivetran_synced"), '1900-01-01'::timestamp_tz)
    from {{ this }}
)
{% endif %}