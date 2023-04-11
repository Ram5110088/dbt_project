-- macro to generate SQL statement
{% macro delete_duplicate_records(schema_name,table_name) %}

{% set delete_query %}
delete FROM {{schema_name}}.{{table_name}} 
WHERE id IN (
  SELECT id FROM (
    SELECT id, ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS row_num
    FROM {{schema_name}}.{{table_name}}
  ) t
  WHERE row_num > 1
)
and updated_at < (SELECT max(updated_at )FROM {{schema_name}}.{{table_name}});

{% endset %}

{{ delete_query }}

{% endmacro %}
