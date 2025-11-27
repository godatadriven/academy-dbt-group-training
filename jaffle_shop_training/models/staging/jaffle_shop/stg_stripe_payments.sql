with source as (
        select * from {{ source('jaffle_shop', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        amount

      from source
  )
  select * from renamed
    