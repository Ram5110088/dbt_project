
{% snapshot test_rk_snapshot %}

{% set source_schema = var('source_schema') %}
{% set source_table = var('source_table') %}
{% set target_table = var('target_table') %}

    {{
        config(
          target_schema='snapshot_schema',
          alias = target_table,
          strategy='timestamp',
          unique_key='id',
          updated_at='updated_at', 
        )
    }}

    select *,CURRENT_TIMESTAMP as load_date from {{source_schema}}.{{source_table}}

{% endsnapshot %}