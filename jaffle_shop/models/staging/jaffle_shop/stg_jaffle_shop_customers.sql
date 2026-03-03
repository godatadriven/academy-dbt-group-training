with source as (
        select * from {{ source('jaffle_shop', 'customers') }}
  ),
  renamed as (
      select
          id as customer_id,
        {{ adapter.quote("first_name") }},
        {{ adapter.quote("last_name") }}

      from source
  )
  select * from renamed
    