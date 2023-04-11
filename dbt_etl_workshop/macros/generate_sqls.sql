{% macro generate_model(staging_table, staging_schema, int_table) %}
    
    insert into {{ int_table }} (id,name,updated_at)
        SELECT *
        FROM {{staging_schema}}.{{ staging_table }}
{% endmacro %}
