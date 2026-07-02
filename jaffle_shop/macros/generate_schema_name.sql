{#
    Use the custom schema name *as-is* when one is configured (e.g. `+schema:
    raw_jaffle_shop`), instead of dbt's default behaviour of prefixing it with
    the target schema (which would give `dbt_dev_raw_jaffle_shop`).

    This lets the seeds live in a fixed `raw_jaffle_shop` schema that models can
    reference directly, while models without a custom schema still build into the
    user's own target schema (e.g. dbt_<name>).
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
