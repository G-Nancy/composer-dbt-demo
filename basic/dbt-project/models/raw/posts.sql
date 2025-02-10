-- This model is an example of a table that use incremental, insert_overwrite, static partition
-- This model is the lowest cost possible based on the dbt public documentation
-- https://docs.getdbt.com/reference/resource-configs/bigquery-configs#the-insert_overwrite-strategy


{{ config(
    owner='data_engineer',
    materialized='incremental',
    unique_key='id',
    partition_by={
      "field": "last_activity_date",
      "data_type": "timestamp",
      "granularity": "day"
    }
)}}

SELECT *
FROM 
  {{ source('bigquery_public_data', 'stackoverflow_posts') }} 

{% if is_incremental() %}
WHERE EXTRACT(DATE from last_activity_date) = PARSE_DATE('%Y-%m-%d','{{ var("execution_date") }}')
{% endif %}

{% if target.name == 'local'%}
LIMIT 1000
{% endif %}