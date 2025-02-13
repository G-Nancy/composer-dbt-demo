-- This model is an example of a table that use incremental, merge strategy
-- https://docs.getdbt.com/reference/resource-configs/bigquery-configs#the-merge-strategy

{{ config(
    owner='data_engineer',
    materialized='incremental',
    unique_key='surrogate_key',
    partition_by={
      "field": "last_activity_date",
      "data_type": "date",
      "granularity": "day"
    }
)}}

SELECT 
  EXTRACT(DATE from last_activity_date) as last_activity_date,
  owner_user_id,
  concat(EXTRACT(DATE from last_activity_date),owner_user_id) as surrogate_key,
  count(id) as total_post

FROM 
  {{ ref('stackoverflow_posts') }}

{% if is_incremental() %}
WHERE 
  EXTRACT(DATE from last_activity_date) = PARSE_DATE('%Y-%m-%d','{{ var("execution_date") }}')
{% endif %}

GROUP BY 
  last_activity_date, 
  owner_user_id,
  surrogate_key