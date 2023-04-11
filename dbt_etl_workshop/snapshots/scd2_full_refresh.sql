{% snapshot t2_listing %}

{{
  config(
    target_schema = 'snapshot_schema',
    alias = 'scd2_full_refresh',
    unique_key = 'id',
    strategy = 'check',
    check_cols = 'all',
    full_refresh = True,
    post_hook =" delete from {{this}} where dbt_valid_to is not null" 
    )
}}

select *, 
       CURRENT_TIMESTAMP as load_date
from int_sales.test_rk

{% endsnapshot %}