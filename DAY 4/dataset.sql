-- Create Database
CREATE DATABASE IF NOT EXISTS Ecommerce_DB;
USE Ecommerce_DB;

-- Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Sample Data
INSERT INTO customers (name, email, join_date, city) VALUES
('John Smith', 'john.smith@email.com', '2023-01-15', 'New York'),
('Emma Johnson', 'emma.j@email.com', '2023-02-10', 'Los Angeles'),
('Michael Brown', 'm.brown@email.com', '2023-01-20', 'Chicago'),
('Sarah Davis', 'sarahd@email.com', '2023-03-05', 'Miami'),
('Robert Wilson', 'rob.wilson@email.com', '2023-02-28', 'Seattle'),
('Lisa Miller', 'lisa.m@email.com', '2023-03-12', 'Boston'),
('David Taylor', 'd.taylor@email.com', '2023-01-05', 'Austin'),
('Jennifer Lee', 'j.lee@email.com', '2023-04-01', 'San Francisco'),
('James Anderson', 'j.anderson@email.com', '2023-03-18', 'Denver'),
('Jessica Thomas', 'jess.t@email.com', '2023-02-22', 'Portland');

INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Wireless Headphones', 'Electronics', 99.99, 50),
('Bluetooth Speaker', 'Electronics', 79.50, 30),
('Smartphone Case', 'Accessories', 29.99, 100),
('Laptop Sleeve', 'Accessories', 24.50, 75),
('Desk Lamp', 'Home', 45.00, 40),
('Coffee Maker', 'Home', 89.99, 25),
('Running Shoes', 'Fashion', 120.00, 60),
('Winter Jacket', 'Fashion', 199.99, 35),
('Fitness Tracker', 'Electronics', 129.99, 45),
('Yoga Mat', 'Sports', 35.00, 80);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-03-15', 'Delivered'),
(2, '2023-03-18', 'Shipped'),
(3, '2023-03-20', 'Pending'),
(1, '2023-04-01', 'Delivered'),
(4, '2023-03-25', 'Delivered'),
(5, '2023-04-02', 'Pending'),
(6, '2023-03-28', 'Shipped'),
(7, '2023-03-30', 'Delivered'),
(8, '2023-04-03', 'Pending'),
(9, '2023-03-22', 'Delivered'),
(10, '2023-03-19', 'Cancelled'),
(2, '2023-04-05', 'Pending'),
(3, '2023-04-01', 'Shipped'),
(1, '2023-04-04', 'Pending');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 3, 2), (1, 5, 1),
(2, 1, 1), (2, 10, 1),
(3, 7, 1), (3, 8, 1),
(4, 2, 1), (4, 4, 3),
(5, 6, 1), (5, 9, 1),
(6, 3, 1), (6, 7, 1),
(7, 5, 2), (7, 10, 1),
(8, 1, 1), (8, 3, 1),
(9, 4, 2), (9, 6, 1),
(10, 9, 1), (10, 10, 1),
(11, 2, 1),
(12, 1, 1), (12, 3, 1),
(13, 5, 1), (13, 8, 1),
(14, 6, 2);