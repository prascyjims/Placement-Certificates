-- Create tables for the retail sales project

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    email VARCHAR(150),
    city VARCHAR(100)
);

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(100),
    unit_price DECIMAL(12,2)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30)
);

CREATE TABLE order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(12,2)
);
