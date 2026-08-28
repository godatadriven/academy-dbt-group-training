# products

`products.sql` is a demo source for Slowly Changing Dimensions: `price` and
`updated_at` are recomputed on every query, so they never hold still. The
snapshot in `snapshots/products_snapshot.sql` (strategy `timestamp`,
`updated_at='updated_at'`) tracks the history of price over time.

## Usage

**Load the seed data** (once, or after editing `raw_products.csv`):

```
dbt seed --select raw_products
```

**Refresh the data** (recomputes price/updated_at):

```
dbt run --select products
```

**Snapshot it** (captures the current price as a new version if changed):

```
dbt snapshot
```

Repeat `dbt run` + `dbt snapshot` a few times to build up history.

**Show the result:**

```
dbt show --inline 'select product_id, price, dbt_valid_from, dbt_valid_to from dbt_dev.products_snapshot order by product_id, dbt_valid_from' --limit -1
```

## Querying the history

**Current price** (one row per product, like a normal table):

```sql
select *
from dbt_dev.products_snapshot
where dbt_valid_to is null
```

**Price as of a specific point in time** (the whole reason to use a
snapshot instead of a plain table — you can answer "what was true then"):

```sql
select *
from dbt_dev.products_snapshot
where product_id = 1
  and dbt_valid_from <= '2026-08-25 11:33:00'
  and (dbt_valid_to > '2026-08-25 11:33:00' or dbt_valid_to is null)
```

`dbt_valid_from` / `dbt_valid_to` mark the window each version was current
for; `dbt_valid_to is null` means "still current."
