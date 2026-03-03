with customers as (

select 
    *
from {{ ref("stg_jaffle_shop_customers") }}

),

orders as (

select 
    *
from {{ ref("stg_jaffle_shop_orders")}}

),

payments as
(
select customer_id, sum(payment_amount) lifetime_value
from {{ref("fct_orders")}}
group by customer_id
),

customer_orders as (

    select
        o.customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders as o 

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        p.lifetime_value,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders on 
    customers.customer_id = customer_orders.customer_id

    left join payments as p on customers.customer_id = p.customer_id

)

select * from final