
CREATE TABLE `users` (
    `id` int  NOT NULL ,
    `first_name` varchar(20)  NOT NULL ,
    `last_name` varchar(20)  NOT NULL ,
    `password` varchar(200)  NOT NULL ,
    `email` varchar(30)  NOT NULL ,
    `created` datetime  NOT NULL ,
    `updated` datetime  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `products` (
    `id` int  NOT NULL ,
    `product_name` varchar(30)  NOT NULL ,
    `created_by` varchar(40)  NOT NULL ,
    `crated_at` datetime  NOT NULL ,
    `updated_at` datetime  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `stocks` (
    `id` int  NOT NULL ,
    `product_id` int  NOT NULL ,
    `created_by` varchar(40)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `updated_at` datetime  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `supplier` (
    `id` int  NOT NULL ,
    `supplier_name` varchar(40)  NOT NULL ,
    `supplier_location` varchar(40)  NOT NULL ,
    `email` varchar(30)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `created_by` varchar(40)  NOT NULL ,
    `updated_at` datetime  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

CREATE TABLE `product_supplier` (
    `id` int  NOT NULL ,
    `supplier` varchar(40)  NOT NULL ,
    `product` varchar(40)  NOT NULL ,
    `quantity_ordered` int  NOT NULL ,
    `quantity_recieved` int  NOT NULL ,
    `quantity_remaining` int  NOT NULL ,
    `status` varchar(30)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `created_by` varchar(40)  NOT NULL ,
    `updated_at` datetime  NOT NULL ,
    PRIMARY KEY (
        `id`
    )
);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_id` FOREIGN KEY(`id`)
REFERENCES `stocks` (`product_id`);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_created_by` FOREIGN KEY(`created_by`)
REFERENCES `users` (`id`);

ALTER TABLE `supplier` ADD CONSTRAINT `fk_supplier_created_by` FOREIGN KEY(`created_by`)
REFERENCES `users` (`id`);

ALTER TABLE `product_supplier` ADD CONSTRAINT `fk_product_supplier_supplier` FOREIGN KEY(`supplier`)
REFERENCES `supplier` (`id`);

ALTER TABLE `product_supplier` ADD CONSTRAINT `fk_product_supplier_product` FOREIGN KEY(`product`)
REFERENCES `products` (`id`);

ALTER TABLE `product_supplier` ADD CONSTRAINT `fk_product_supplier_created_by` FOREIGN KEY(`created_by`)
REFERENCES `users` (`id`);

