-- WG4 (incremental models): a duplicate of the orders model, rebuilt as an
-- incremental model. On a full run it builds every row; on later runs the
-- is_incremental() block restricts the scan to orders newer than what is already
-- loaded, and the merge strategy upserts them on order_id.

{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge',
    file_format='delta'
) }}

with orders as (

    select * from {{ ref('stg_jaffle_shop__orders') }}

)

select *
from orders

{% if is_incremental() %}

-- Only process orders placed after the most recent order already in this table.
where order_date > (select max(order_date) from {{ this }})

{% endif %}
