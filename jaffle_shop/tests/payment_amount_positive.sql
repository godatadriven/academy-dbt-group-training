select
    order_id,
    total_amount
from {{ ref('fct_orders') }}
group by 1
having total_amount < 0