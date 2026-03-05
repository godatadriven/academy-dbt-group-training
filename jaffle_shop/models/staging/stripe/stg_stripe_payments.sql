with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        order_id,
        payment_method,
        status as payment_status,
        payment_amount as payment_amount,
        {{convert_to_cents('payment_amount')}} as payment_amount_cents,
      from source
  )
  select * from renamed
    