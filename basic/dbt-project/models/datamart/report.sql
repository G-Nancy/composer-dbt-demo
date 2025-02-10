{{ config(
    owner='data_analysts',
    cluster_by = ["id"]
)}}

SELECT 
    EXTRACT(year from last_activity_date) as last_activity_year,
    EXTRACT(month from last_activity_date) as last_activity_month,
    owner_user_id,
    reputation,
    views,
    SUM(total_post) as total_post
FROM 
    {{ ref('fact_posts_daily') }} fact_posts_daily 
JOIN 
    {{ ref('dim_users') }} dim_users ON fact_posts_daily.owner_user_id = dim_users.id
GROUP BY 
    last_activity_year, 
    last_activity_month, 
    owner_user_id, 
    reputation, 
    views