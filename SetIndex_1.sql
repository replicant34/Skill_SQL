CREATE INDEX idx_cust_id ON orders (cust_id);
CREATE INDEX idx_add_id ON orders (add_id);
CREATE INDEX idx_item_id ON orders (item_id);
CREATE INDEX idx_comp_id ON components (comp_id);
CREATE INDEX idx_comp_id ON assembling (comp_id);
CREATE INDEX idx_sku ON item (sku);
CREATE INDEX idx_item_id ON inventory (item_id);
CREATE INDEX idx_staff_id ON rota (staff_id);
CREATE INDEX idx_shift_id ON rota (shift_id);