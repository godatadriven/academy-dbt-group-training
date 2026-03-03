select 
id as payment_id,
order_id, 
payment_method, 
status as payment_status,
payment_amount
from {{ source("stripe", "payments")}}
    