-- stg_name_of_source_name_of_table

with source as (
        select * from {{ source('jaffle_app', 'customers') }}
  ),
  renamed as (
      select
        {{ adapter.quote("ID") }} as customer_id,  -- rename to a standardized name
        {{ adapter.quote("FIRST_NAME") }},
        {{ adapter.quote("LAST_NAME") }}

      from source
  )
  select * from renamed
    