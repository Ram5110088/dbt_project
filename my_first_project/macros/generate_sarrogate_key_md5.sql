{% macro surrogate_key(column_list) %}
  {{column_list}} || md5(random()::text)
{% endmacro %}