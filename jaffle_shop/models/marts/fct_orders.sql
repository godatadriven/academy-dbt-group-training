with
jaffle_orders AS(
    select
order_id,
customer_id
FROM {{ref("stg_jaffle_shop_orders")}}
),

payment AS(
    select
    order_id,
    sum(payment_amount) as payment_amount
    FROM {{ref("stg_stripe_payment_data")}}
    WHERE payment_status = "success"
    GROUP BY order_id
)

select
j.order_id,
j.customer_id,
p.payment_amount
FROM jaffle_orders j
LEFT JOIN payment p
ON j.order_id=p.order_id