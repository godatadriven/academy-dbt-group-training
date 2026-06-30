with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
          payment_id,
          order_id,
          payment_method,
          {{ cents_to_dollars(column_name = 'payment_amount') }} as payment_amount,
          payment_date
      from source
  )
  select * from renamed