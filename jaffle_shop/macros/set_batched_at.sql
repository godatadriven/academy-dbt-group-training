{#
    Returns the SQL that makes the Stripe payments batch look `hours_ago` hours old.
    Used as a seed post-hook and by the `age_payments` operation below.
#}
{% macro set_batched_at(hours_ago=18, relation=none) -%}
    {%- set relation = relation or this -%}
    update {{ relation }}
    set _BATCHED_AT = (current_timestamp - interval '{{ hours_ago }} hours')::timestamp
{%- endmacro %}

{#
    Trainer helper: `dbt run-operation age_payments --args '{hours_ago: 30}'`
    Makes the source freshness check pass, warn or fail on demand.
#}
{% macro age_payments(hours_ago=18) %}
    {% set relation = ref('raw_payments') %}
    {% do run_query(set_batched_at(hours_ago=hours_ago, relation=relation)) %}
    {{ log("Set " ~ relation ~ "._BATCHED_AT to " ~ hours_ago ~ " hours ago", info=True) }}
{% endmacro %}
