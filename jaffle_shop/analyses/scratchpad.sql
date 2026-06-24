select distinct payment_method
from {{ ref("stg_stripe_payments") }}