-- WG1 - Pivot payments, stage 1: pure SQL.
-- One row per order, one column per payment method, using an explicit CASE
-- expression per method. This is an `analysis`: it compiles to target/compiled
-- for inspection but is never materialised in the warehouse.

with payments as (

    select * from {{ ref('stg_jaffle_shop__payments') }}

)

select
    order_id,

    sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount,
    sum(case when payment_method = 'coupon'        then amount else 0 end) as coupon_amount,
    sum(case when payment_method = 'credit_card'   then amount else 0 end) as credit_card_amount,
    sum(case when payment_method = 'gift_card'     then amount else 0 end) as gift_card_amount,

    sum(amount) as total_amount

from payments

group by order_id
