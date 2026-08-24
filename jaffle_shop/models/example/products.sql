-- Product catalog with a live, randomized price.
--
-- Unlike customers/orders, this view has no fixed state: price is
-- recomputed with random() on every query, so it looks different each
-- time it's read. That's intentional -- it's the "changing source" used
-- to demo Slowly Changing Dimensions via snapshots/products_snapshot.sql.
-- Run `dbt snapshot` more than once to see the price history build up.

select
    id as product_id,
    product_name,
    category,
    -- Price in EUR, recomputed on every query to simulate a source that
    -- changes over time (demoed via snapshots).
    round(random() * 5 + 1, 2) as price

from raw_jaffle_shop.products
