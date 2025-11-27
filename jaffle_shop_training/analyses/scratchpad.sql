/*
dbt run-operation generate_source --args '{"schema_name": "data_warehousing", "generate_columns": true}'

$ dbt run-operation generate_model_yaml --args '{"model_names": ["dim_customers"]}'

$ dbt run-operation generate_model_import_ctes --args '{"model_name": "fct_orders"}'
*/

select
    *
from
    {{ source('jaffle_shop', 'customers') }}
where id is null

select
    id, count(*)
from 
    {{ source('jaffle_shop', 'customers') }}
group by id
having count(*) > 1



with source as (
        select * from {{ source('jaffle_shop', 'payments') }}
  ),
  renamed as (
      select
        id as payment_id,
        orderid as order_id,
        paymentmethod,
        amount

      from source
  )
  select * from renamed
  where payment_id is null