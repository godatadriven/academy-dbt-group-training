-- can we move this to the yaml configuration?
-- how to only test the last X days?


select * 
from {{ ref("dim_customers") }}
where number_of_orders < 0