# products

`products.sql` is the demo source for Slowly Changing Dimensions. The price and
`updated_at` come from the seed `raw_products`. The snapshot in
`snapshots/products_snapshot.sql` (strategy `timestamp`, `updated_at='updated_at'`)
records the price history.

## Usage

**Load the seed data** (once, or to reset all prices):

```
dbt seed --select raw_products
```

**Build the model and take the first snapshot:**

```
dbt run --select products
dbt snapshot
```

**Snapshot again without a change.** The snapshot adds no rows, because
nothing changed:

```
dbt snapshot
```

**Change one price in the source, then snapshot again:**

```
dbt run-operation bump_price --args '{product_id: 3, new_price: 3.10}'
dbt snapshot
```

The muffin now has two rows: the old price with a `dbt_valid_to`, and the new
price with `dbt_valid_to is null`.

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

**Price as of a specific point in time** (the reason to use a snapshot instead
of a plain table: you can answer "what was true then"):

```sql
select *
from dbt_dev.products_snapshot
where product_id = 3
  and dbt_valid_from <= '2026-08-25 11:33:00'
  and (dbt_valid_to > '2026-08-25 11:33:00' or dbt_valid_to is null)
```

`dbt_valid_from` / `dbt_valid_to` mark the window each version was current
for. `dbt_valid_to is null` means "still current."
