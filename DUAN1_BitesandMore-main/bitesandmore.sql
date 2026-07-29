CREATE DATABASE BitesandMore;
GO
USE BitesandMore;
GO

CREATE TABLE categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255)
);

CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT FOREIGN KEY REFERENCES categories(id) ON DELETE SET NULL,
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    rating INT DEFAULT 5,
    image VARCHAR(500),
    description NVARCHAR(MAX)
);

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    address NVARCHAR(255),
    role VARCHAR(20) DEFAULT 'customer',
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE orders (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES users(id) ON DELETE SET NULL,
    customer_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method NVARCHAR(50) DEFAULT 'COD',
    status NVARCHAR(50) DEFAULT 'Pending',
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE order_details (
    id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT FOREIGN KEY REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT FOREIGN KEY REFERENCES products(id) ON DELETE SET NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO categories (name, description) VALUES 
(N'Breads', N'Freshly baked artisanal breads'),
(N'Cakes', N'Custom birthday and layer cakes'),
(N'Pastries', N'Flaky French pastries and tarts'),
(N'Cupcakes', N'Sweet bite-sized cupcakes');

INSERT INTO products (category_id, name, price, rating, image, description) VALUES 
(1, N'Sourdough Bread', 6.00, 5, 'https://images.unsplash.com/photo-1586444248902-2f64eddc13df?w=500', N'Freshly baked sourdough bread with crispy crust.'),
(4, N'Chocolate Cupcake', 3.50, 4, 'https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?w=500', N'Rich chocolate cupcake topped with buttercream.'),
(3, N'Strawberry Tart', 5.20, 4, 'https://images.unsplash.com/photo-1519869325930-281384150729?w=500', N'Fresh strawberry tart with delicious cream base.'),
(2, N'Red Velvet Cake', 18.00, 5, 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?w=500', N'Classic Red Velvet cake with cream cheese frosting.');

INSERT INTO users (first_name, last_name, email, password, phone, address, role) VALUES 
(N'Admin', N'Bakery', 'admin@bitesandmore.com', '123456', '0905123456', N'123 Bakery St, Da Nang', 'admin'),
(N'John', N'Doe', 'john@example.com', '123456', '0905999888', N'456 Ocean Road, Da Nang', 'customer');

INSERT INTO orders (user_id, customer_name, phone, address, total_amount, payment_method, status) VALUES 
(2, N'John Doe', '0905999888', N'456 Ocean Road, Da Nang', 27.50, 'Credit Card', 'Pending');

INSERT INTO order_details (order_id, product_id, price, quantity) VALUES 
(1, 1, 6.00, 1),
(1, 2, 3.50, 1),
(1, 4, 18.00, 1);