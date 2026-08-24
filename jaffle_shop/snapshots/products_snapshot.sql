{% snapshot products_snapshot %}

{{
    config(
      target_schema='dbt_dev',
      unique_key='product_id',
      strategy='check',
      check_cols=['price'],
    )
}}

select * from {{ ref('products') }}

{% endsnapshot %}
