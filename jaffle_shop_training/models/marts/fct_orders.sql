with payments as (
        select * from {{ ref('stg_stripe_payments') }}
  ),

orders as (
        select * from {{ ref('stg_jaffle_shop_orders') }}
  ),

  order_payments as (
      select
        orders.order_id,
        customer_id,
        amount

      from payments
    
    left join orders on payments.order_id = orders.order_id
  )
  select * from order_payments