-- add this file into the models directory
-- once you have run dbt seed, update this query to include the correct schema (dataset) and run the query

with customers as (

select 
    id as customer_id,
    first_name as first_name,
    last_name as last_name
from <dataset_name>.raw_customers

),

orders as (

select 
        id as order_id,
        user_id as customer_id,
        order_date as order_date,
        status as order_status
from <dataset_name>.raw_orders

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
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders on 
    customers.customer_id = customer_orders.customer_id

)

select * from final