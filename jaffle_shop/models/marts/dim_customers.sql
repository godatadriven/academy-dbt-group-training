with customers as (

select 
    *
from {{ ref("stg_jaffle_shop_customers") }}

),

orders as (

select 
    *
from {{ ref("stg_jaffle_shop_orders") }}

),

payments as (

select 
    order_id
    , sum(payment_amount) as amount
from {{ ref("stg_stripe_payments") }}
group by order_id

),

orders_payments as (
    select
        orders.order_id
        , orders.customer_id
        , orders.order_date
        , orders.order_status
        , payments.amount
    from orders

    left join payments on 
    orders.order_id = payments.order_id
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(amount) as lifetime_value

    from orders_payments

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
        customer_orders.lifetime_value

    from customers

    left join customer_orders on 
    customers.customer_id = customer_orders.customer_id

)

select * from final