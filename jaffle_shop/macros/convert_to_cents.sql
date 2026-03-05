{% macro convert_to_cents(amount) -%}
    {{ amount }} * 100
{%- endmacro %}