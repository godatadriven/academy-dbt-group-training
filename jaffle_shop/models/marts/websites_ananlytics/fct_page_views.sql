{{
    config(
        materialized='incremental',
        unique_key='event_id',
        on_schema_change='sync_all_columns'

    )
}}
-- check data after batched_at date:

with page_views as (
select *
from {{ref("stg_snow_plow_events_page_views")}}
{% if is_incremental() %}
where batched_at > (select dateadd(day, -3, max(batched_at)) from {{this}})
{% endif %}
)

select * from page_views
where browser IN ('Chrome', 'Safari', 'Firefox')