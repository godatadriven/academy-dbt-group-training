{% test greater_or_equal_to_0(model, column_name) %}

select *
from {{ model }}
where {{ column_name }} < 0

{% endtest %}