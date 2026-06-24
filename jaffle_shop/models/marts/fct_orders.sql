with orders as (

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

final as (

    select
        orders.order_id
        , orders.customer_id
        , orders.order_date
        , orders.order_status
        , payments.amount
    from orders

    left join payments on 
    orders.order_id = payments.order_id
)

select * from final