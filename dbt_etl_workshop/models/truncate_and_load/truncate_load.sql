{% set source_schema = var('source_schema') %}
{% set source_table = var('source_table') %}
{% set target_table = var('target_table') %}
-- create the model that loads data from int_table to dwh_table
{{  config(materialized='table', 
           schema='truncate_and_load_schema', 
           alias=target_table,
           ) }}

SELECT 
{{autoincrement_surrogate_key()}} as sid,
  *,
  CURRENT_TIMESTAMP as load_date 
FROM {{source_schema  }}.{{ source_table }}
