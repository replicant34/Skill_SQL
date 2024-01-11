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