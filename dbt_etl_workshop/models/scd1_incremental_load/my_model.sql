{% set source_schema = var('source_schema') %}
{% set source_table = var('source_table') %}
{% set target_table = var('target_table') %}

{% set column_list = ['id','name','updated_at'] %}
{% set my_hook = delete_duplicate_records('scd1_incremental_load_schema', target_table) %}

-- create the model that loads data from int_table to dwh_table
{{  config(materialized='incremental', 
           schema='scd1_incremental_load_schema', 
           alias=target_table,
           post_hook =my_hook,
           ) 
           }}

SELECT 
{{ surrogate_key("id") }} as sid,
  id,
  "name",
  updated_at,
  CURRENT_TIMESTAMP as load_date 
FROM {{source_schema  }}.{{ source_table }}
{% if is_incremental() -%}
where updated_at > (select max(updated_at) from {{ this }})
{%- endif %}
