select 
    order_id,
    customer_id,
    order_date,
    order_status
from {{ref("stg_jaffle_shop_orders")}}
where order_date > current_date
