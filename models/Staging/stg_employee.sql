{{config(materialized = 'table', transient = false)}}

select *
from 
{{source('qwt_raw','raw_employee')}}