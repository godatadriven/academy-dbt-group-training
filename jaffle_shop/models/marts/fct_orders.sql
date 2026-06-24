with orders as (

select 
    *
from {{ ref("stg_jaffle_shop_orders")}}

),

payments as (

select
    order_id,
    sum(payment_amount) as total_amount
from {{ ref("stg_stripe_payments")}}

    group by order_id

),




final as (

    select
        payments.order_id,
        payments.total_amount,
        orders.customer_id,
        orders.order_date,
        orders.order_status

    from payments
    left join orders on 
    orders.order_id = payments.order_id

)


select *
from final