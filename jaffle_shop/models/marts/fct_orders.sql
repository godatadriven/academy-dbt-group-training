select o.customer_id, o.order_id, p.payment_amount
from {{ref("stg_stripe_payments")}} as p
inner join {{ref("stg_jaffle_shop_orders")}} as o
where 1=1
and p.order_id = o.order_id
order by o.customer_id