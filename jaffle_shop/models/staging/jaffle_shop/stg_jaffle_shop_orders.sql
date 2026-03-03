with source as (
        select * from {{ source('jaffle_shop', 'orders') }}
  ),
  renamed as (
      select
        id as order_id,
        user_id as customer_id,
        status as order_status,
        order_date,
        batched_at

      from source
  )
  select * from renamed
    