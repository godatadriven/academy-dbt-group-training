with source as (
    select * from {{ source('stripe', 'payments') }}
)

select * from source;