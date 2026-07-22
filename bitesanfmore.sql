CREATE DATABASE BitesandMore;
USE BitesandMore;

CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating INT DEFAULT 5
);

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    role VARCHAR(20) DEFAULT 'customer'
);

INSERT INTO products (name, price, rating) VALUES 
('Sourdough Bread', 6.00, 5),
('Chocolate Cupcake', 3.50, 4),
('Strawberry Tart', 5.20, 4),
('Red Velvet Cake', 18.00, 5);

INSERT INTO users (first_name, last_name, email, password, phone, role) 
VALUES (N'Admin', N'Bakery', 'admin@bitesandmore.com', '123456', '0905123456', 'admin');