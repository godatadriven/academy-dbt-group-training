select sum(lifetime_value) from {{ ref("dim_customers") }}

-- is this count is bigger than 0 than we have nulls, I.e. the test fails