with 
    
    orders as (select * from {{ ref('stg_jaffle_shop_orders') }}),
    
    payments as (select * from {{ ref('stg_stripe_payments') }}),

order_payments as (

    select
        order_id,

        sum(payment_amount) as order_amount

    from payments

    group by 1

),


final as (

    select
        orders.*,
        order_payments.order_amount

    from orders

    left join order_payments 
    on orders.order_id = order_payments.order_id

)

select * from final