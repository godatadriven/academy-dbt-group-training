 {{ config(
    materialized='view'
) }}

with source as (
        select * from {{ source('stripe', 'payment_data') }}
  ),
  renamed as (
      select
        id as payment_id,
        order_id,
        payment_method, 
        status as payment_status,
        payment_amount
      from source
  )
  select * from renamed

    
 