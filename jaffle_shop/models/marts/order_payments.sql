-- WG1 - Pivot payments, stage 3: refactored with dbt_utils (WG3).
-- dbt_utils.get_column_values reads the distinct payment methods from the
-- warehouse and dbt_utils.pivot generates the CASE expressions, so adding a new
-- payment method requires no code change at all. The `default` list keeps the
-- first run / parse safe before the upstream relation exists.

with payments as (

    select * from {{ ref('stg_jaffle_shop__payments') }}

)

select
    order_id,

    {{ dbt_utils.pivot(
        column='payment_method',
        values=dbt_utils.get_column_values(
            ref('stg_jaffle_shop__payments'),
            'payment_method',
            default=['bank_transfer', 'coupon', 'credit_card', 'gift_card']
        ),
        agg='sum',
        then_value='amount',
        suffix='_amount'
    ) }},

    sum(amount) as total_amount

from payments

group by order_id
