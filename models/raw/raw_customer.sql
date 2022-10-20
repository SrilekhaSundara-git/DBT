{{
    config(
        materialized='table'
    )
}}

SELECT *
--FROM raw.globalmart.customer#
FROM {{ source('globalmart', 'customer') }}