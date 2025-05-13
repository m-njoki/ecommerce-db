-- Create the database
CREATE DATABASE IF NOT EXISTS CLOTHING_ECOMMERCE;

-- Select the database
USE CLOTHING_ECOMMERCE;

-- 1. Users Table (Customers and Admins)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    address VARCHAR(255),
    is_admin BOOLEAN DEFAULT FALSE,
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Brand Table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

-- 3. Product Category Table
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- 4. Product Table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INT,
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

-- 5. Color Table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7) -- Example: #FFFFFF
);

-- 6. Size Category Table
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_name VARCHAR(100) NOT NULL
);

-- 7. Size Option Table
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_name VARCHAR(50) NOT NULL,
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- 8. Product Variation Table (Links products with color and size options)
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_option_id INT,
    stock_quantity INT DEFAULT 0,
    price DECIMAL(10, 2), -- Price may differ based on variation
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- 9. Product Image Table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- 10. Order Table
CREATE TABLE `order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shipping_address VARCHAR(255),
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 11. Order Item Table (Details of each product in an order)
CREATE TABLE order_item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_variation_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES `order`(order_id),
    FOREIGN KEY (product_variation_id) REFERENCES product_variation(variation_id)
);

-- 12. Payment Table
CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method ENUM('Credit Card', 'PayPal', 'Cash on Delivery'),
    payment_status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(order_id)
);

-- 13. Product Review Table
CREATE TABLE product_review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 14. Shipping Table
CREATE TABLE shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_method ENUM('Standard', 'Express', 'Same Day'),
    shipping_status ENUM('Pending', 'Shipped', 'Delivered') DEFAULT 'Pending',
    tracking_number VARCHAR(100),
    shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(order_id)
);

-- Insert sample data for testing

-- Insert Brands
INSERT INTO brand (brand_name) VALUES 
('Nike'), 
('Adidas'), 
('Puma');

-- Insert Product Categories
INSERT INTO product_category (category_name) VALUES 
('T-Shirts'), 
('Jeans'), 
('Jackets'), 
('Shoes');

-- Insert Colors
INSERT INTO color (color_name, hex_code) VALUES 
('Red', '#FF0000'),
('Black', '#000000'),
('Blue', '#0000FF'),
('White', '#FFFFFF');

-- Insert Size Categories
INSERT INTO size_category (size_category_name) VALUES 
('T-Shirt Size'), 
('Jeans Size'), 
('Shoe Size');

-- Insert Size Options
INSERT INTO size_option (size_name, size_category_id) VALUES 
('M', 1), 
('L', 1),
('32', 2),
('34', 2),
('42', 3),
('44', 3);

-- Insert Products
INSERT INTO product (product_name, description, base_price, brand_id, category_id) VALUES
('Nike Air T-Shirt', 'A comfortable cotton T-shirt with a Nike logo.', 30.00, 1, 1),
('Adidas Slim Fit Jeans', 'Stylish and comfortable slim fit jeans.', 50.00, 2, 2),
('Puma Running Shoes', 'Durable and lightweight shoes for running.', 70.00, 3, 4);

-- Insert Product Variations
INSERT INTO product_variation (product_id, color_id, size_option_id, stock_quantity, price) VALUES
(1, 1, 1, 100, 30.00),  -- Nike Air T-Shirt, Red, Size M
(1, 2, 2, 150, 30.00),  -- Nike Air T-Shirt, Black, Size L
(2, 3, 3, 80, 50.00),   -- Adidas Slim Fit Jeans, Blue, Size 32
(3, 4, 5, 50, 70.00);   -- Puma Running Shoes, White, Size 42

-- Insert Product Images
INSERT INTO product_image (product_id, image_url) VALUES
(1, 'https://example.com/nike_air_tshirt.jpg'),
(2, 'https://example.com/adidas_jeans.jpg'),
(3, 'https://example.com/puma_shoes.jpg');

-- Insert Users (Customers)
INSERT INTO users (username, password, email, first_name, last_name, address, is_admin) VALUES
('john_doe', 'password123', 'john.doe@example.com', 'John', 'Doe', '1234 Elm St, Springfield, IL', FALSE),
('jane_smith', 'password456', 'jane.smith@example.com', 'Jane', 'Smith', '5678 Oak St, Springfield, IL', FALSE);

-- Insert Order
INSERT INTO `order` (user_id, total_amount, shipping_address, order_status) VALUES
(1, 80.00, '1234 Elm St, Springfield, IL', 'Pending');

-- Insert Order Items
INSERT INTO order_item (order_id, product_variation_id, quantity, price) VALUES
(1, 1, 2, 30.00), -- 2 Nike Air T-Shirts
(1, 3, 1, 50.00); -- 1 Adidas Slim Fit Jeans

-- Insert Payment
INSERT INTO payment (order_id, payment_method, payment_status) VALUES
(1, 'Credit Card', 'Completed');

-- Insert Shipping
INSERT INTO shipping (order_id, shipping_method, shipping_status, tracking_number) VALUES
(1, 'Standard', 'Shipped', 'TRK123456');
