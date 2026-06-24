with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
          {{ adapter.quote("payment_id") }},
        {{ adapter.quote("order_id") }},
        {{ adapter.quote("payment_method") }},
        {{ adapter.quote("payment_amount") }} / 100 as payment_amount,
        {{ adapter.quote("payment_date") }}

      from source
  )
  select * from renamed
    