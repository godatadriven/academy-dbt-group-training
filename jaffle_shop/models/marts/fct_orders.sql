with 
    payments as (

        select *
        from {{ ref('stg_stripe_payments') }}

    ),

    customers as (

        select *
        from {{ ref('stg_jaffle_shop_customers') }}

    ),

    orders as (

        select *
        from {{ ref('stg_jaffle_shop_orders') }}

    ),


    order_payment as (

        select
            order_id,
            sum(amount) as total_amount

        from payments

        group by order_id

    ),



    final as (

        select
            orders.*,
            order_payment.total_amount,

        from orders

        left join order_payment on 
        orders.order_id = order_payment.order_id

    )

select * from final

