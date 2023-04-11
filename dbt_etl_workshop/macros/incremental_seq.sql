{% macro autoincrement_surrogate_key(sequence_name) %}
    ROW_NUMBER() OVER ()
{% endmacro %}
