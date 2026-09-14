{#
    Simulates a price change in the source system:
    dbt run-operation bump_price --args '{product_id: 3, new_price: 3.10}'
    Run `dbt seed --select raw_products` to reset all prices.
#}
{% macro bump_price(product_id, new_price) %}
    {% set relation = ref('raw_products') %}
    {% set sql %}
        update {{ relation }}
        set price = {{ new_price }},
            updated_at = current_timestamp::timestamp
        where id = {{ product_id }}
    {% endset %}
    {% do run_query(sql) %}
    {{ log("Product " ~ product_id ~ " now costs " ~ new_price, info=True) }}
{% endmacro %}
