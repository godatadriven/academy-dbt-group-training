-- Scratchpad: a place to "just query the tables"
-- --------------------------------------------------------------------------
-- Highlight any query below and run it (the dbt Power User "Preview", or your
-- SQL tool of choice) to see the data.
--
-- These queries use plain `FROM schema.table` on purpose. dbt analyses would
-- normally use `ref()` / `source()`, but those are introduced later in the
-- training. The goal of this file is simply to let you explore the tables with
-- SQL you already know, before learning the dbt-specific functions.
-- --------------------------------------------------------------------------


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
