
{{
  config(
    materialized='table',
    schema = 'dwh_sales',
  )
}}


select
  listid as listid,
  total_order_amount as total_order_amount,
  total_orders as no_of_order
from
  {{ ref('temp_table') }}
