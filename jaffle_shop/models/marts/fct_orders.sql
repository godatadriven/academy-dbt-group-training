-- add this file into the models directory
-- once you have run dbt seed, update this query to include the correct schema (dataset) and run the query

with 

    orders as ( select * from  {{ref('stg_jaffle_shop_orders')}}),

    payments as ( select * from {{ref('stg_stripe_payments')}}
    where payment_status <> 'fail' ),

    group_payments as (

    select
        order_id,
        sum(amount) as order_amount

    from payments

    group by 1

),


final as (

    select
        orders.*,
        group_payments.order_amount

    from orders
    left join group_payments on 
    orders.order_id = group_payments.order_id

)

select * from final