with source as (

    select * from {{ source('jaffle_shop', 'payments') }}

),

renamed as (

    select
        -- Surrogate key built with the custom `surrogate_key` macro (WG2). `id`
        -- is already unique here, so combining it with `order_id` is purely
        -- illustrative; surrogate keys earn their keep on models whose grain is
        -- a combination of columns with no single natural key.
        {{ surrogate_key('order_id', 'id') }} as payment_pk,

        id as payment_id,
        order_id,
        payment_method,
        status as payment_status,

        -- `amount` is stored in cents in the source; convert to dollars.
        amount / 100.0 as amount

    from source

)

select * from renamed
