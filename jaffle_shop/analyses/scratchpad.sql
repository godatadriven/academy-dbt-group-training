-- Scratchpad
-- --------------------------------------------------------------------------
-- A place to check your data. Highlight a query below and run it (the dbt
-- Power User "Preview", or your SQL tool of choice) to see the results.
-- The ref() versions are compiled by dbt; the plain ones query the database
-- directly.


-- ============================ Raw sources =================================
-- The raw jaffle data lives in the `raw_jaffle_shop` schema.

-- customers source
select * from raw_jaffle_shop.customers;

-- customers source using the ref() function
select * from {{ ref('raw_customers') }};

-- orders source
select * from raw_jaffle_shop.orders;

-- orders source using the ref() function
select * from {{ ref('raw_orders') }};

-- payments source
select * from raw_jaffle_shop.payments;

-- payments source using the ref() function
select * from {{ ref('raw_payments') }};


-- ============================ Your models =================================
-- When you run `dbt run`, your models are built into the `dbt_dev` schema.
-- (If you set a custom DBT_SCHEMA, swap `dbt_dev` for your own schema name.)

-- customers model
select * from dbt_dev.customers;

-- customers model using the ref() function
select * from {{ ref('customers') }};
