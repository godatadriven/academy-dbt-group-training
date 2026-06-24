with orders as (

select 
    *
from {{ ref("stg_jaffle_shop_orders")}}

),

payments as (
    select
        order_id,
        SUM(payment_amount) as total_amount
    from {{ ref("stg_stripe_payments")}}
    group by order_id
),

final as (
    select 
     payments.order_id,
     orders.customer_id,
     orders.order_date,
     orders.orderstatus,
     payments.total_amount
    from payments
    left join orders 
    on payments.order_id = orders.order_id
)

select *
from final