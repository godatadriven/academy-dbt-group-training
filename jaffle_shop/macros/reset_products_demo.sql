{#
    Drops the products snapshot so the SCD demo starts from zero again.
    dbt never rebuilds a snapshot table, so this is the only way to clear
    the history. Use together with a reseed:

        dbt seed --select raw_products
        dbt run-operation reset_products_demo
#}
{% macro reset_products_demo() %}
    {% set relation = ref('products_snapshot') %}
    {% do run_query("drop table if exists " ~ relation) %}
    {{ log("Dropped " ~ relation ~ ". Run `dbt snapshot` to start a new history.", info=True) }}
{% endmacro %}
