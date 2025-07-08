-- add this file into the models directory
-- once you have run dbt seed, update this query to include the correct schema (dataset) and run the query

with payments as (

select 
    *
from {{ ref('stg_stripe_payments') }}

),

orders as (

select 
        *
from {{ ref('stg_jaffle_shop_orders') }}

),



final as (

    select
        orders.customer_id,
        orders.order_id,
        payments.amount
    from orders

    left join payments on 
        orders.order_id = payments.order_id

)

select * from final