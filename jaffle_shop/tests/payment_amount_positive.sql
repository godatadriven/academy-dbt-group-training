select
    payment_id,
    payment_amount
from {{ ref('stg_stripe_payments') }}
where payment_amount < 0