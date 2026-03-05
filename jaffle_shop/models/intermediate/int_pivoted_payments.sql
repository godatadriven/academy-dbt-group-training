-- select 
-- order_id,
-- sum(case when payment_method = 'credit_card' then payment_amount else 0 end) as credit_card_amount,
-- sum(case when payment_method = 'bank_transfer' then payment_amount else 0 end) as bank_transfer_amount,
-- sum(case when payment_method = 'coupon' then payment_amount else 0 end) as coupon_amount,
-- sum(case when payment_method = 'gift_card' then payment_amount else 0 end) as gift_card_amount

-- from {{ ref("stg_stripe_payments") }}

-- remove the trailing comma with jinja
-- make the for loop dynamic - get the payment methods from the data instead of hardcoding them
-- put the payment methods in a variable at the top of the file so it's easier to maintain
-- remove newlines
{% set payment_methods = dbt_utils.get_column_values(ref('stg_stripe_payments'), 'payment_method') %}

select 
order_id,
{%- for payment_method in payment_methods %}
sum(case when payment_method = '{{ payment_method }}' then payment_amount else 0 end) as {{ payment_method }}_amount
{%- if not loop.last %},{% endif %}
{%- endfor %}
from {{ ref("stg_stripe_payments") }}
group by order_id