with fct_reviews as (
    select *
    from {{ ref('fct_reviews')}}
),

dim_listings_cleansed as (
    select *
    from {{ ref('dim_listings_cleansed')}}
)


select * 
from fct_reviews f
join dim_listings_cleansed d
on f.listing_id = d.listing_id
where f.review_date < d.created_at