{% snapshot products_snapshot %}

{{
    config(
      target_schema='dbt_dev',
      unique_key='product_id',
      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ ref('products') }}

{% endsnapshot %}
