select * from {{ source('jaffle_shop', "orders")}}
 where order_date > cast(getdate() as date)