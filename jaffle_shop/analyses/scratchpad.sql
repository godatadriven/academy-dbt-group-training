-- ============================ Raw sources =================================
-- The raw jaffle data lives in the `raw_jaffle_shop` schema.

-- customers source
select * from raw_jaffle_shop.customers;

-- orders source
select * from raw_jaffle_shop.orders;

-- payments source
select * from raw_jaffle_shop.payments;


-- ============================ Your models =================================
-- When you run `dbt run`, your models are built into the `dbt_dev` schema.
-- (If you set a custom DBT_SCHEMA, swap `dbt_dev` for your own schema name.)

-- customers model
select * from dbt_dev.customers;
