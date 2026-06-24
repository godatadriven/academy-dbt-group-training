with source as (
        select * from {{ source('jaffle_shop', 'customers') }}
  ),
  renamed as (
      select
        {{ adapter.quote("id") }}         as customer_id,
        {{ adapter.quote("first_name") }} as first_name,
        {{ adapter.quote("last_name") }}  as last_name

      from source
   )
  select * from renamed
    