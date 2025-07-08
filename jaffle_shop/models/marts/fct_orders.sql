with orders as (

select  
    *
from {{ ref('stg_jaffle_shop_orders') }}

),

payments as (

select 
    *
from {{ ref('stg_stripe_payments') }}

),

order_payments as (

    select
        order_id,
            sum(amount) as total_amount  

    from payments

    group by order_id

)

select  
    orders.*,
    order_payments.total_amount

    from orders

    left join order_payments on
    order_payments.order_id = orders.order_id
