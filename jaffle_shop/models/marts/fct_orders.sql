with orders as (

select 
    *
from {{ ref("stg_jaffle_shop_orders") }}

),

payments as (

select 
    *
from {{ ref("stg_stripe_payments") }}

),

payments_per_order as (

  select
    order_id
    , sum(payment_amount) as sum_amount
  from payments
  group by order_id    

),

final as (

  select
    ppo.order_id
    , ppo.sum_amount
    , o.customer_id
  from payments_per_order as ppo
  left join orders as o
  on ppo.order_id = o.order_id
)

select * from final