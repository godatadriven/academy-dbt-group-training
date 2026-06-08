{#
    Generate a surrogate key by concatenating two columns and MD5-hashing the
    result. This is a deliberately simple, two-column version of
    dbt_utils.generate_surrogate_key, written by hand so participants can see
    exactly what such a macro does.

    Usage:
        select {{ surrogate_key('order_id', 'payment_method') }} as my_key, ...

    Notes:
    - Each field is cast to a string and null-coalesced, so NULLs hash to a
      stable sentinel instead of producing a NULL key.
    - A '-' delimiter separates the fields so that e.g. ('1','23') and
      ('12','3') do not collide.
#}
{% macro surrogate_key(field_a, field_b) %}
    md5(concat(
        coalesce(cast({{ field_a }} as string), '_dbt_null_'),
        '-',
        coalesce(cast({{ field_b }} as string), '_dbt_null_')
    ))
{% endmacro %}
