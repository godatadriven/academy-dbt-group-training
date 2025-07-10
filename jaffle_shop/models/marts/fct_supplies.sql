with products as (

select  
    *
from {{ ref('stg_operations_products') }}

),

supplies as (

select 
    *
from {{ ref('stg_operations_supplies') }}

),

supply_usage as (

   SELECT 
  supply_id,
  supply_name,
  COUNT(*) AS times_used
FROM 
  supplies
GROUP BY 
  supply_id,
  supply_name

)

select * from supply_usage


