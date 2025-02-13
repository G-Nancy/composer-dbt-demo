{{ config(
    owner='data_engineer',
    materialized='table',
    cluster_by = ["id"]
)}}

SELECT 
  id, 
  display_name, 
  reputation, 
  views    
FROM 
  {{ ref('users') }}