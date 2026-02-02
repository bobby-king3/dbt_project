{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with src_reviews as (
    SELECT * FROM {{ ref('src_reviews')}}
)

select *
from src_reviews
where review_text is NOT NULL
{% if is_incremental() %}
    and review_date > (select max(review_date) from {{ this }})
{% endif %}