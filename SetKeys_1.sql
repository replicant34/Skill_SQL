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
