select * from  {{ source('jaffle_shop', 'customers')}}
where id is null
-- if this count > 0 then the test failed. 

select * from raw_stripe.payment_data