{% set source_schema = var('source_schema') %}
{% set source_table = var('source_table') %}
{% set target_schema = var('target_schema') %}
{% set target_table = var('target_table') %}
{{
  config(
    materialized='incremental',
    schema='scd1_full_refresh_schema',
    alias=target_table,
    full_refresh = True
  )
}}
select *,CURRENT_TIMESTAMP as load_date from {{ source_schema }}.{{ source_table }}
{% if is_incremental() -%}
where  listtime> (select max(listtime) from {{ this }})
{%- endif %}


