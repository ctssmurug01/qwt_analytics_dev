{{config(materialized = 'table')}}

select 
orderid,
lineno,
shipperid,
customerid,
productid,
employeeid,
split_part(shipmentdate, ' ',1)::date as shipmentdate,
--truncate(date(shipmentdate,'mm/dd/yyyy hh:mm')) as shipmentdate,
status 
from 
{{source('qwt_raw','raw_shipments')}}