select
    o.order_id
    , c.customer_id
    , sum(p.amount/100) as amount
 
from {{ref("stg_jaffle_shop_orders")}} as o
    left join {{ref("stg_jaffle_shop_customers")}} as c on o.customer_id = c.customer_id
    left join {{ref("stg_stripe_payments")}} as p on o.order_id = p.order_id
 
group by
    o.order_id
    , c.customer_id