select * 
from {{ ref('dim_customers') }}
where number_of_orders not between 0 and 1000

