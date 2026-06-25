select sum(lifetime_value) as total_revenue
from {{ ref("dim_customers") }}