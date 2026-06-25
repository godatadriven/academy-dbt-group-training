with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
          id as payment_id,
          orderid as order_id,
          paymentmethod as payment_method,
          amount/100 as payment_amount,
          status
      from source
  )
  select * from renamed