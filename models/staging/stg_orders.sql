select
--from raw_orders
{{ dbt_utils.surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders,
orderid,
orderdate,
shipdate,
o.shipmode,
o.customerid,
o.productid,
ordersellingprice,
ordercostprice,
--from raw_customer
customername,
segment,
country,
--from raw_product
category,
productname,
subcategory,
{{ markup('ordersellingprice', 'ordercostprice' ) }} as markup,
ordersellingprice - ordercostprice as orderprofit,
-- from delivery_team
delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
left join {{ ref('delivery_team') }} as d
on o.shipmode = d.shipmode
