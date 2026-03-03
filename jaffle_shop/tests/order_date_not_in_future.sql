select
*
FROM {{ref("stg_jaffle_shop_orders")}}
WHERE order_date>current_date