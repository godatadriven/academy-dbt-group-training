with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
          ID as payment_id,
          ORDERID as order_id,
          PAYMENTMETHOD as method,
          STATUS as pay_status,
          cast(AMOUNT/100 as float64) as amount,
          CREATED as pay_day,
          _BATCHED_AT as onbekend

      from source
  )
  select * from renamed
    