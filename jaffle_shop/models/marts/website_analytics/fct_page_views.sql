{{
    config(
        materialized = 'incremental',
        unique_key = 'event_id',
        on_schema_change = 'sync_all_columns'
    )
}}

with page_views as (
    select *
    from {{ ref('stg_snowplow_events_page_views')}}
{% if is_incremental() %} 
    where batched_at > ( select dateadd(day, -3, max(batched_at)) from {{ this }})
{% endif%}
)
select * 
from {{ ref('stg_snowplow_events_page_views') }}
where browser in ('Chrome', 'Safari', 'Firefox')