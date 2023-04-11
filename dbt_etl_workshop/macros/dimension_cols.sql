{% macro dim_type_1_cols(t1_cols, dim_name, inc_prefix, t2_prefix, source_prefix) %}
    {% for col in t1_cols -%}
        {% if is_incremental() -%}
            case when ({{inc_prefix}}.dbt_valid_to is null  
                        and {{inc_prefix}}.t1_key != {{source_prefix}}.t1_key) then {{source_prefix}}.{{col}}
                when ({{inc_prefix}}.t1_key is not null) then {{inc_prefix}}.{{col}}
                else {{t2_prefix}}.{{col}} end as {{col}} {%- if not loop.last -%},{%- endif -%}
        {%- else %} 
            case when ({{t2_prefix}}.dbt_valid_to is null 
                        and {{t2_prefix}}.t1_key != {{source_prefix}}.t1_key ) then {{source_prefix}}.{{col}}
                else {{t2_prefix}}.{{col}} end as {{col}} {%- if not loop.last -%},{%- endif -%}
        {%- endif %}
    {% endfor -%}
{% endmacro %}