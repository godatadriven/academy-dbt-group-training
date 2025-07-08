select 
    sum(total_amount) 
from {{ ref('fct_orders') }}