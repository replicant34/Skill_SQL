CREATE TABLE stock1 (
    row_id int NOT NULL,
    item_name varchar(100) NOT NULL, 
    comp_id varchar(20) NOT NULL,  
    comp_name varchar(100) NOT NULL, 
    comp_weight int NOT NULL, 
    comp_price decimal(5,2) NOT NULL,
    order_quantity int NOT NULL,
    assembling_quantity decimal(5,3) NOT NULL, 
    ordered_weight decimal(6,2) NOT NULL,
    unit_cost decimal(5,2) NOT NULL,
    component_cost decimal(6,2) NOT NULL,
    primary key (row_id)
);

SELECT
	s2.comp_name,
	s2.ordered_weight,
	comp.comp_weight * inv.quantity AS total_inv_weight,
	(comp.comp_weight * inv.quantity)-s2.ordered_weight as remaining_weight
FROM
	( SELECT comp_id, comp_name, sum( ordered_weight ) AS ordered_weight FROM stock2 GROUP BY comp_name, comp_id ) s2
	LEFT JOIN inventory inv ON inv.item_id = s2.comp_id
	LEFT JOIN components comp ON comp.comp_id = s2.comp_id