with source as (
        select * from {{ source('operations', 'supplies') }}
  ),
  renamed as (
      select
      id as supply_id,
      name as supply_name, 
      cost as supply_cost, 
      perishable as supply_perishable,
      sku as product_id

      from source
  )
  select * from renamed