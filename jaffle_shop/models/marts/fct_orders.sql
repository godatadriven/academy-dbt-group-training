with orders as (

select
    order_id,
    customer_id,
    order_date,
    order_status
from {{ ref("stg_jaffle_shop_orders") }}

),

payments as (

select
    order_id,
    amount
from {{ ref("stg_stripe_payments") }}

),

order_payments as (

    select
        order_id,
        sum(amount) as amount

    from payments

    group by 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
        coalesce(order_payments.amount, 0) as amount

    from orders

    left join order_payments on
    orders.order_id = order_payments.order_id

)

select * from final
