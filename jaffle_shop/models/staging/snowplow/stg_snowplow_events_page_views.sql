with source as (
        select * from {{ source('snowplow_events', 'page_views') }}
  ),
  renamed as (
      select
          {{ adapter.quote("event_id") }},
        {{ adapter.quote("user_id") }},
        {{ adapter.quote("session_id") }},
        {{ adapter.quote("page_url") }},
        {{ adapter.quote("device_type") }},
        {{ adapter.quote("browser") }},
        {{ adapter.quote("country") }},
        {{ adapter.quote("referrer") }},
        {{ adapter.quote("duration_seconds") }},
        {{ adapter.quote("is_bounce") }},
        {{ adapter.quote("datetime") }} as batched_at

      from source
  )
  select * from renamed
    