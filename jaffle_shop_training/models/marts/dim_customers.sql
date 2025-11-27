-- add this file into the models directory
-- once you have run dbt seed, update this query to include the correct schema (dataset) and run the query

with customers as (

select 
    *
from {{ ref('stg_jaffle_shop_customers') }}

),

orders as (

select 
    *
from {{ ref('stg_jaffle_shop_orders') }}

),

payments as (

select 
    *
from {{ ref('stg_stripe_payments') }}

),


customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        sum(amount) / 100 as lifetime_value

    from customers

    left join customer_orders on 
    customers.customer_id = customer_orders.customer_id

    left join payments on
    order_id = payments.order_id

    group by 1,2,3,4,5,6
)

select * from final