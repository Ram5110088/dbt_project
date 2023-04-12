{% macro autoincrement_surrogate_key() %}
    ROW_NUMBER() OVER(order by NULL )
{% endmacro %}
