select * 
  from raw_stripe.payment_data

select * 
  from dim_customers
  raw_stripe.payment_data pd
  
select * from stg_payment_data pd
  --left join dim_customers dc on pd.customer_id = dc.customer_id
select distinct payment_status from stg_payment_data pd

  select * from dim_customers dc