with payments as (
    select * from {{ ref('stg_stripe_payments') }}
),

orders as (
    select * from {{ ref('stg_jaffle_shop_orders') }}
)

select 
    order_id,
    customer_id,
    sum(amount) as total_amount
    from orders
    left join payments using (order_id)
    group by 1,2