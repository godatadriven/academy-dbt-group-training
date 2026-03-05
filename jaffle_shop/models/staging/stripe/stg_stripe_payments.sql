with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        order_id,
        payment_method,
        status as payment_status,
        payment_amount as payment_amount

      from source
  )
  select * from renamed
    