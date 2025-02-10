{{ config(
    owner='data_engineer',
    materialized='table',
    cluster_by = ["id"]
)}}

SELECT * FROM {{ source('bigquery_public_data', 'users') }}

{% if target.name == 'local' %}
LIMIT 1000
{% endif %}