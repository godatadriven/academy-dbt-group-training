select customer_id, 
        sum(amount) as amount
from fct_orders
group by customer_id