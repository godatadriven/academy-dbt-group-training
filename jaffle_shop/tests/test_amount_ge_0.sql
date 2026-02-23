select * 
from {{ ref('stg_stripe_payments') }}
where payment_amount < 0