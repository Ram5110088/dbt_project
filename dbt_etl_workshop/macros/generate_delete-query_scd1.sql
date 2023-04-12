-- macro to generate SQL statement
{% macro delete_duplicate_records(schema_name,table_name) %}

{% set delete_query %}

delete FROM {{schema_name}}.{{table_name}}  
 WHERE (id, updated_at) NOT IN (
 SELECT id, max(updated_at) FROM {{schema_name}}.{{table_name}}  
 GROUP BY id);

{% endset %}

{{ delete_query }}

{% endmacro %}
