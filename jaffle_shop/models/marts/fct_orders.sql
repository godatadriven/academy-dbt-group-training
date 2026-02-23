with payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
),

order_payments as (
    select
        order_id,
        sum(payment_amount) as order_amount
    from payments
    group by 1
),

final as (
    select 
        order_payments.order_id,
        orders.customer_id,
        order_payments.order_amount
    from order_payments
    left join orders using (order_id)
)

select * from final