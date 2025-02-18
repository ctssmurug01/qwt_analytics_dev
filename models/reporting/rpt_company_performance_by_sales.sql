{{config(materialized ='view', schema = 'reporting_dev')}}

select
dc.companyname as customername,
dc.contactname as contactname,
min(fo.orderdate) as first_order_date,
max(fo.orderdate) as recent_order_date,
count(distinct fo.orderid) as total_orders,
count(distinct dp.productname) as total_products ,
sum(fo.quantity) as total_quanity ,
sum(fo.linesalesamount) as total_sales ,
avg(fo.margin) as avg_margin

from
{{ref("fct_orders")}} fo inner join 
{{ref("dim_customers")}} dc
on fo.customerid = dc.customerid
inner join 
{{ref("dim_products")}} dp
on dp.productid = fo.productid
group by
dc.companyname ,dc.contactname
