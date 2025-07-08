with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        amount as amount_cents,
        amount/100 as amount, 
        created,
        _BATCHED_AT,

      from source
  )
  select * from renamed
    