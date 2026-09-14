-- Product catalog. The price and updated_at come straight from the source
-- table. Change a price with
--   dbt run-operation bump_price --args '{product_id: 3, new_price: 3.10}'
-- then run `dbt snapshot` to record the new version.

select
    id as product_id,
    product_name,
    category,
    price,
    updated_at

from {{ ref('raw_products') }}
