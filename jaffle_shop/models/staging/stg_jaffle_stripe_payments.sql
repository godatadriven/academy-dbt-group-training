with source as (
        select * from {{ source('stripe', 'payments') }}
  ),
  renamed as (
      select
        {{ adapter.quote("payment_id") }}      as payment_id,
        {{ adapter.quote("order_id") }}        as order_id,
        {{ adapter.quote("payment_method") }}  as payment_method,
        {{ adapter.quote("payment_amount") }}  as payment_amount,
        {{ adapter.quote("payment_date") }}    as payment_date
      from source
   )
  select * from renamed
    