select *
from {{ source('jaffle_shop', 'customers')}}
where id is null