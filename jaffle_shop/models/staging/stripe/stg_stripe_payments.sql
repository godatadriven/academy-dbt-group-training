with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        ORDERID as order_id,
        PAYMENTMETHOD as payment_method,
        STATUS as payment_status,
        AMOUNT/100 as amount,
        CREATED as created,
        _BATCHED_AT as batched_at

      from source
  )
  select * from renamed
    