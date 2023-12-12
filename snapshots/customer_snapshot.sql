{% snapshot customer_snapshot %}

    {{
        config(
          target_database='analytics',
          target_schema='snapshots',
          strategy='check',
          unique_key='c_custkey',
          check_cols='all',
        )
    }}

    select * from {{ source('tpch_sf1', 'customer') }}

{% endsnapshot %}