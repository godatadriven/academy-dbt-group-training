with orders as
  (select
    *
  from
    {{ref('stg_jaffle_shop_orders')}}
  )
, payments as
(select
  *
from
  {{ref('stg_jaffle_shop_payments')}}
)
select 
  o.order_id,
  o.customer_id,
  sum(p.amount)/100 as amount
from 
  orders o
left join
  payments p
on
  o.order_id = p.order_id
group by
  o.order_id,
  o.customer_id