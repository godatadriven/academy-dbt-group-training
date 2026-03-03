with source as (
        select * from {{ source('jaffle_shop', 'customers') }}
  ),
  renamed as (
      select
          {{ adapter.quote("id") }} customer_id,
        {{ adapter.quote("first_name") }},
        {{ adapter.quote("last_name") }}

      from source
  )
  select * from renamed
    