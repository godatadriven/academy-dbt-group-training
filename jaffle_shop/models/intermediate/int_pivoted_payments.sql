-- set the list of payment methods at the top of the file using jinja
-- trim the whitespace for the compiled output
-- how to remove the last trailing comma
-- use a distinct/ get the unique values from the column payment_method

{%- set payment_method_list = dbt_utils.get_column_values(table=ref('stg_stripe_payments'), column='payment_method') %}

select 
    order_id,
{%- for payment_method in payment_method_list %}
    sum( case when payment_method = '{{payment_method}}' then payment_amount else 0 end) as {{payment_method}}_amount{% if not loop.last %},{% endif %}
{%- endfor %}

 from {{ ref("stg_stripe_payments")}}
 group by order_id
