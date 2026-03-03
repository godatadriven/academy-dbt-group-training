{{ config(
    materialized='table'
) }}
      
  

with customers as (

select 
    customer_id,
    first_name,
    last_name
from {{ref("stg_jaffle_shop_customers")}}

),

orders as (

select 
    order_id,
    customer_id,
    order_date,
    order_status
from {{ref("stg_jaffle_shop_orders")}}

), order_payments as (

    select
        order_id,
        sum(payment_amount) as total_payment_amount,
        count(payment_id) as number_of_payments
    from {{ref("stg_payment_data")}}
    group by order_id
),
customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(op.total_payment_amount) as total_amount_paid,
        sum(op.number_of_payments) as number_of_payments        
    from orders od
    left join order_payments op using (order_id)
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
        coalesce(customer_orders.number_of_payments, 0) as number_of_payments,
        coalesce(customer_orders.total_amount_paid, 0) as total_amount_paid        
    from customers

    left join customer_orders on 
    customers.customer_id = customer_orders.customer_id

)

select * from final