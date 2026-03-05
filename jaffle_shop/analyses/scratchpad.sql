--Even if you add the comments, there is no way to comment the jinja code.
{# This is a scratchpad for testing out dbt_utils.get_query_results_as_dict. It is not intended to be run as part of the dbt project, but rather to be used as a sandbox for trying out the macro. #}

{% set sql_statement %}
    select distinct payment_method, NULL from {{ ref('stg_stripe_payments') }}
{% endset %}

{%- set example = dbt_utils.get_query_results_as_dict(sql_statement) -%}

{{ sql_statement }}

{# Another comment #}