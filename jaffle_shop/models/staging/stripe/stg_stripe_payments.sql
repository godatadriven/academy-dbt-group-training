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
      id as payment_id,
      orderid as order_id,
      paymentmethod as payment_method,
      status as payment_status,
      cast(amount/100 as float64) as payment_amount,
      created,
      _batched_at

      from source
  )
  select * from renamed
    