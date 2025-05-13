# ecommerce-db

# Clothing E-commerce Database

This is a database schema for a clothing e-commerce platform. The schema manages product listings, user data, orders, payment processing, and shipping details. It supports key e-commerce features such as product variations, customer reviews, and stock management.

# Features
-Users: Manage customer and admin accounts.
-Products: Catalog of clothing items with details like name, description, price, brand, and category.
-Product Variations: Different color and size options for each product.
-Orders: Tracks customer orders, including items purchased, quantity, and total amount.
-Payments: Records payment details, including payment method and status.
-Shipping: Manages shipping methods, status, and tracking numbers.
-Reviews: Allows customers to rate and review products.

# Tables
1. users: Stores customer and admin details.
2. brand: Contains product brand information.
3. product\_category: Categorizes products (e.g., T-shirts, jeans, shoes).
4. product: Main product table that stores product details.
5. color: List of available colors for product variations.
6. size\_category: Categorizes sizes (e.g., T-shirt size, jeans size).
7. size\_option: Size options for products, such as S, M, L, 32, 34.
8. product\_variation: Links products with color and size variations, and tracks stock levels.
9. product\_image: Stores product images linked to specific products.
10. order: Tracks customer orders, shipping address, and status.
11. order\_item: Stores individual items within an order.
12. payment: Contains payment information for orders.
13. shipping: Tracks the shipping status and details of each order.
14. product\_review: Allows customers to leave reviews and ratings for products.

# Usage
- Add products, manage categories, and update stock via the `product`, `product_category`, and `product_variation` tables.
- Manage orders and payments through the `order`, `order_item`, and `payment` tables.
- Keep track of shipping and reviews for customer interaction.
