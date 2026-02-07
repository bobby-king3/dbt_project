{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with src_reviews as (
    SELECT * FROM {{ ref('src_reviews')}}
)

select 
  {{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }}
    AS review_id,
*
from src_reviews
where review_text is NOT NULL
{% if is_incremental() %}
    and review_date > (select max(review_date) from {{ this }})
{% endif %}