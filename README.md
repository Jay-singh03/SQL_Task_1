# SQL_Task_1

** Project Overview**
This project implements a complete E-commerce Database Schema as part of an SQL Developer Internship Task. The database manages products, customers, orders, and categories for an online store.

** Database Schema**

#Tables Structure
1. categories
Stores product categories (Electronics, Clothing, Books, Home & Kitchen)

Primary Key: category_id (Auto-increment)

2. products
Contains product details with pricing and stock information

Primary Key: product_id

Foreign Key: category_id → categories(category_id)

3. customers
Stores customer information with unique email constraints

Primary Key: customer_id

4. orders
Tracks customer orders with status and total amount

Primary Key: order_id

Foreign Key: customer_id → customers(customer_id)

5. order_items (Junction Table)
Resolves many-to-many relationship between orders and products

Primary Key: order_item_id

Foreign Keys: order_id → orders(order_id), product_id → products(product_id)


**Relationships**
- One-to-Many: Categories → Products

- One-to-Many: Customers → Orders

- Many-to-Many: Orders ↔ Products (via order_items junction table)


 **Key Features**

 # Constraints Implemented
- PRIMARY KEY for unique identification

- FOREIGN KEY for referential integrity

- UNIQUE constraints on email and product combinations

- CHECK constraints for positive prices and quantities

- NOT NULL for required fields

**Data Integrity**
- CASCADE DELETE: Orders are deleted when customers are removed

- SET NULL: Product category is set to NULL if category is deleted

- Unique Constraints: Prevent duplicate products in same order
