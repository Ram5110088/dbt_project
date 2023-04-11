{% set source_schema = var('source_schema') %}
{% set source_table = var('source_table') %}
{{
  config(
    materialized='ephemeral'
  )
}}

SELECT
  listid as listid,
  SUM(numtickets*price) AS total_order_amount,
  COUNT(DISTINCT sellerid) AS total_orders
FROM
  {{ source_schema }}.{{source_table}}
GROUP BY
  listid
