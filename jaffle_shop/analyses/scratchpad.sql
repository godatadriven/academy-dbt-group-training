select * from dbt_ldanvers.dim_customers

select 
    sum(total_amount) as total_amount_all
from {{ ref('fct_orders') }} ;
