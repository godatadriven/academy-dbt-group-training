select
    *,
from {{ ref("stg_stripe_payments") }}

select * from snowplow.page_views
order by datetime desc