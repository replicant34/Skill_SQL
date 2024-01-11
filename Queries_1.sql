CREATE TABLE orders (
    row_id INT NOT NULL,
    order_id VARCHAR(10) NOT NULL,
    created_at DATETIME NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    cust_id INT NOT NULL,
    delivery BOOLEAN NOT NULL,
    add_id INT NOT NULL,
    PRIMARY KEY (row_id)
);

CREATE TABLE customers (
    cust_id INT NOT NULL,
    cust_firstname VARCHAR(50) NOT NULL,
    cust_lastname VARCHAR(50) NOT NULL,
    PRIMARY KEY (cust_id)
);

CREATE TABLE address (
    add_id INT NOT NULL,
    delivery_address1 VARCHAR(200) NOT NULL,
    delivery_address2 VARCHAR(200) NULL,
    delivery_county VARCHAR(50) NOT NULL,
    delivery_eircode VARCHAR(20) NOT NULL,
    PRIMARY KEY (add_id)
);

CREATE TABLE item (
    item_id VARCHAR(10) NOT NULL,
    sku VARCHAR(20) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    item_cat VARCHAR(100) NOT NULL,
    item_size VARCHAR(10) NOT NULL,
    item_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (item_id)
);

CREATE TABLE components (
    comp_id VARCHAR(10) NOT NULL,
    comp_name VARCHAR(200) NOT NULL,
    comp_weight INT NOT NULL,
    comp_meas VARCHAR(20) NOT NULL,
    comp_price DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (comp_id)
);

CREATE TABLE assembling (
    row_id INT NOT NULL,
    assembly_id VARCHAR(20) NOT NULL,
    comp_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (row_id)
);


CREATE TABLE inventory (
    inv_id INT NOT NULL,
    item_id VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (inv_id)
);

CREATE TABLE rota (
    row_id INT NOT NULL,
    roster_id VARCHAR(20) NOT NULL,
    date_id DATETIME NOT NULL,
    shift_id VARCHAR(20) NOT NULL,
    staff_id VARCHAR(20) NOT NULL,
    PRIMARY KEY (row_id)
);

CREATE TABLE staff (
    staff_id VARCHAR(20) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    hourly_rate DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (staff_id)
);

CREATE TABLE shift (
    shift_id VARCHAR(20) NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    PRIMARY KEY (shift_id)
);

CREATE INDEX idx_cust_id ON orders (cust_id);
CREATE INDEX idx_add_id ON orders (add_id);
CREATE INDEX idx_item_id ON orders (item_id);
CREATE INDEX idx_comp_id ON components (comp_id);
CREATE INDEX idx_comp_id ON assembling (comp_id);
CREATE INDEX idx_sku ON item (sku);
CREATE INDEX idx_item_id ON inventory (item_id);
CREATE INDEX idx_staff_id ON rota (staff_id);
CREATE INDEX idx_shift_id ON rota (shift_id);

ALTER TABLE customers ADD CONSTRAINT fk_customers_cust_id FOREIGN KEY(cust_id)
REFERENCES orders (cust_id);
ALTER TABLE address ADD CONSTRAINT fk_address_add_id FOREIGN KEY(add_id)
REFERENCES orders (add_id);
ALTER TABLE item ADD CONSTRAINT fk_item_item_id FOREIGN KEY(item_id)
REFERENCES orders (item_id);
ALTER TABLE components ADD CONSTRAINT fk_components_comp_id FOREIGN KEY(comp_id)
REFERENCES assembling (comp_id);
ALTER TABLE assembling ADD CONSTRAINT fk_assembling_assembly_id FOREIGN KEY(assembly_id)
REFERENCES item (sku);
ALTER TABLE inventory ADD CONSTRAINT fk_inventory_item_id FOREIGN KEY(item_id)
REFERENCES assembling (comp_id);
ALTER TABLE rota ADD CONSTRAINT fk_rota_staff_id FOREIGN KEY(staff_id)
REFERENCES staff (staff_id);
ALTER TABLE rota ADD CONSTRAINT fk_rota_shift_id FOREIGN KEY(shift_id)
REFERENCES shift (shift_id);


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

SELECT
	r.date_id,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	((
			HOUR (
			TIMEDIFF( sh.end_time, sh.start_time ))
			) + (
			MINUTE (
			TIMEDIFF( sh.end_time, sh.start_time )))
	) AS hours_in_shift,
	((
			HOUR (
			TIMEDIFF( sh.end_time, sh.start_time ))
			) + (
			MINUTE (
			TIMEDIFF( sh.end_time, sh.start_time )))
	) * s.hourly_rate AS staff_cost 
FROM
	rota r
	LEFT JOIN staff s ON r.staff_id = s.staff_id
	LEFT JOIN shift sh ON r.shift_id = sh.shift_id;
— save query
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