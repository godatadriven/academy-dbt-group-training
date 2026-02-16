-- What is the difference between run, test & build?

-- build = test + run

-- dbt build --select tag:important
-- dbt test --exclude tag:important

select * from {{ ref('stg_stripe_payments') }}