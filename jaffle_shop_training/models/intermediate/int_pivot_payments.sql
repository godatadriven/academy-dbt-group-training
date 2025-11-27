{%- set payment_table = ref('stg_jaffle_shop_payments') -%}
{%- set payment_methods = dbt_utils.get_column_values(payment_table, 'payment_method') -%}
select 
    p.order_id,
{%- for payment_method in payment_methods %}
    SUM(CASE WHEN p.payment_method = '{{ payment_method }}' THEN amount ELSE 0 END) as {{ payment_method }}_amount{% if not loop.last %},{% endif %}
{%- endfor %}
from 
    {{ payment_table }} p
group by
    p.order_id