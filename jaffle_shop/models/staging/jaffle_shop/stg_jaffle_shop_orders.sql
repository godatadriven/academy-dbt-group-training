with source as (
        select * from {{ source('jaffle_shop', 'orders') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id") }} as order_id,
        {{ adapter.quote("user_id") }} as customer_id,
        {{ adapter.quote("order_date") }},
        {{ adapter.quote("status") }} as order_status

      from source
  )
  select * from renamed
