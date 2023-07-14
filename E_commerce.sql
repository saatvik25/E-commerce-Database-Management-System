use Ecommerce;
-- Create the tables
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  password VARCHAR(100)
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DECIMAL(10, 2),
  inventory INT
);

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10, 2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);



-- Insert sample data
INSERT INTO customers (customer_id, name, email, password)
VALUES (1, 'John Doe', 'john@example.com', 'password');

INSERT INTO products (product_id, name, description, price, inventory)
VALUES (1, 'Product 1', 'Description 1', 10.99, 100);
       -- (2, 'Product 2', 'Description 2', 19.99, 50);


SET SQL_SAFE_UPDATES = 1;

DELETE FROM products WHERE product_id = 5;

-- Get all products
SELECT * FROM products;
-- get all orders
select * from orders;
-- get all customers
select * FROM customers;
-- get all order items
select * from order_items;


ALTER TABLE ORDERS ADD  COLUMN order_date DATE;

ALTER TABLE order_items
DROP FOREIGN KEY order_items_ibfk_1;

ALTER TABLE orders
MODIFY COLUMN order_id INT AUTO_INCREMENT;

ALTER TABLE order_items
ADD CONSTRAINT order_items_ibfk_1 FOREIGN KEY (order_id) REFERENCES orders(order_id);


-- Drop the foreign key constraint to make it auto increment of product id
ALTER TABLE order_items DROP FOREIGN KEY order_items_ibfk_2;

-- Modify the column to make it auto-incrementing primary key
ALTER TABLE products MODIFY COLUMN product_id INT AUTO_INCREMENT;

-- Recreate the foreign key constraint
ALTER TABLE order_items ADD CONSTRAINT order_items_ibfk_2 FOREIGN KEY (product_id) REFERENCES products (product_id);


ALTER TABLE products
MODIFY COLUMN product_id  INT AUTO_INCREMENT;

ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE customers
MODIFY COLUMN customer_id INT AUTO_INCREMENT ;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1 FOREIGN KEY (customer_id) REFERENCES customers(customer_id);



-- Insert an order
INSERT INTO orders (order_id, customer_id, total_amount)
VALUES (1, 1, 10.99);

select * from orders;

-- Insert order items
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES (1, 1, 2, 10.99);



-- Get order details
SELECT o.order_id, c.name AS customer_name, p.name AS product_name, oi.quantity, oi.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_id = 1;

SELECT o.order_id, c.name AS customer_name, p.name AS product_name, oi.quantity, oi.price
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_id = 2;
