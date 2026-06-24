with source as (
    select * from {{ source('stripe', 'payments') }} --normalize amount by 100
)

select * from source --avoid semicolon