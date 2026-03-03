with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
          {{ adapter.quote("id") }} as payment_id,
        {{ adapter.quote("order_id") }},
        {{ adapter.quote("payment_method") }},
        {{ adapter.quote("status") }},
        {{ adapter.quote("payment_amount") }}

      from source
  )
  select * from renamed
    