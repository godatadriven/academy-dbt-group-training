# products

`products.sql` is a demo source for Slowly Changing Dimensions: its `price`
is recomputed with `random()` on every query, so it never holds still. The
snapshot in `snapshots/products_snapshot.sql` (strategy `check`,
`check_cols=['price']`) tracks the history of that price over time.

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
