# Payments data and source freshness

`raw_payments.csv` loads into the `stripe.incoming_payments` table.

Its `_BATCHED_AT` column says when the data "arrived". dbt source freshness
uses this column to decide whether the data is fresh or too old.

## How it works

Every time you run `dbt seed`, `_BATCHED_AT` is set to **18 hours ago** for
every row. The date written in the CSV file is not used.

## Change the age

From inside the `jaffle_shop` folder, run:

```bash
dbt run-operation age_payments --args '{hours_ago: 30}'
```

Change `30` to any number of hours. Then run `dbt source freshness` to see the
result.

What you see depends on the `warn_after` and `error_after` you set on your
source. For example, with `warn_after: 12 hours` and `error_after: 24 hours`:

| `hours_ago` | Result |
|-------------|--------|
| 3           | PASS   |
| 18          | WARN   |
| 30          | ERROR  |

## Good to know

- This only changes **your own** database. Everyone runs it in their own codespace.
- Running `dbt seed` again resets the age to 18 hours.
- The logic lives in `macros/set_batched_at.sql`.
