select * from {{ source('jaffle_shop', 'customers')}}
where id is null

select * from dim_customers

select * from raw_stripe.payment_data

select * from raw_jaffle_shop.orders

select * from {{ref("stg_jaffle_shop_orders")}}