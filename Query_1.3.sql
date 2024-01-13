SELECT
	s1.item_name,
	s1.comp_id,
	s1.comp_name,
	s1.comp_weight,
	s1.comp_price,
	s1.order_quantity,
	s1.assembling_quantity,
	s1.order_quantity * s1.assembling_quantity AS ordered_weight,
	s1.comp_price / s1.comp_weight AS unit_cost,
	( s1.order_quantity * s1.assembling_quantity )*(
		s1.comp_price / s1.comp_weight 
	) AS component_cost 
FROM
	(
	SELECT
		o.item_id,
		i.sku,
		i.item_name,
		r.comp_id,
		comp.comp_name,
		r.quantity AS assembling_quantity,
		sum( o.quantity ) AS order_quantity,
		comp.comp_weight,
		comp.comp_price 
	FROM
		orders o
		LEFT JOIN item i ON o.item_id = i.item_id
		LEFT JOIN assembling r ON i.sku = r.assembly_id
		LEFT JOIN components comp ON comp.comp_id = r.comp_id 
	GROUP BY
		o.item_id,
		i.sku,
		i.item_name,
		r.comp_id,
		r.quantity,
		comp.comp_name,
		comp.comp_weight,
	comp.comp_price 
	) s1