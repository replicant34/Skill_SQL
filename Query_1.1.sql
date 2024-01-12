SELECT
o.order_id,
i.item_price,
o.quantity,
i.item_cat,
i.item_name,
o.created_at,
a.delivery_address1,
a.delivery_address2,
a.delivery_county,
a.delivery_eircode,
o.delivery
From orders o
Left Join item i on o.item_id = i.item_id
Left Join address a on o.add_id = a.add_id