{{config(materialized ='table',schema = 'transforming_dev')}}

select
GET(XMLGET(SUPPLIERSINFO,'SupplierID'),'$') AS SupplierID,
GET(XMLGET(SUPPLIERSINFO,'CompanyName'),'$')::VARCHAR AS CompanyName,
GET(XMLGET(SUPPLIERSINFO,'ContactName'),'$')::VARCHAR AS ContactName,
GET(XMLGET(SUPPLIERSINFO,'Address'),'$')::VARCHAR AS Address,
GET(XMLGET(SUPPLIERSINFO,'City'),'$')::VARCHAR AS City,
GET(XMLGET(SUPPLIERSINFO,'PostalCode'),'$')::VARCHAR AS PostalCode,
GET(XMLGET(SUPPLIERSINFO,'Country'),'$')::VARCHAR AS Country,
GET(XMLGET(SUPPLIERSINFO,'Phone'),'$')::VARCHAR AS Phone,
GET(XMLGET(SUPPLIERSINFO,'Fax'),'$')::VARCHAR AS Fax

from
{{ref('stg_suppliers')}}
