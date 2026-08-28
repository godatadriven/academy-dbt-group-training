-- Product catalog with a live, randomized price.
--
-- Unlike customers/orders, this view has no fixed state: price and
-- updated_at are recomputed on every query, so they look different each
-- time it's read. That's intentional -- it's the "changing source" used
-- to demo Slowly Changing Dimensions via snapshots/products_snapshot.sql.
-- Run `dbt run && dbt snapshot` more than once to see the price history
-- build up (strategy='timestamp' picks up every run since updated_at
-- always moves forward).

select
    id as product_id,
    product_name,
    category,
    round(random() * 3 + 1, 2) + price as price,
    current_timestamp as updated_at

from {{ ref('raw_products') }}
