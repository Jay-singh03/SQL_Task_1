create database E_commerce;
use E_commerce;

# 1. Category Table creation....
create table categories(
	category_id int auto_increment primary key,
    category_name varchar(100) not null,
    description text
);

# Insert Categories....
insert into categories(category_name, description)
values('Electronic', 'Gadgets, devices and electronic accessories'),
('Clothing', 'Fashion items including shirts, pants, and accessories'),
('Books', 'Fiction, non-fiction, educational books'),
('Home & Kitchen', 'Home appliances and kitchen utensils');

# 2. Products Table creation....
create table products(
	product_id int auto_increment primary key,
    product_name varchar(225) not null,
    description text,
    price decimal(10, 2) not null check(price >= 0),
    stock_quantity int not null check(stock_quantity >= 0),
    category_id int,
    created_at timestamp default current_timestamp,
    foreign key (category_id) references categories(category_id) on delete set null
);

# Insert Products....
insert into products (product_name, description, price, stock_quantity, category_id)
values('Smartphone X', 'Latest smartphone with high-resolution camera', 699.99, 50, 1),
('Wireless Headphones', 'Noise-cancelling Bluetooth headphones', 199.99, 100, 1),
('Cotton T-Shirt', 'Comfortabe 100% cotton t-shirt', 24.99, 200, 2),
('Programming Book', 'Complete guide to web development', 49.99, 75, 3),
('Coffee Maker', 'Automatic drip coffee machine', 89.99, 30, 4),
('Laptop Stand', 'Adjustable aluminum laptop stand', 39.99, 60, 1),
('Jeans', 'Classic blue denim jeans', 59.99, 80, 2),
('Cookbook', 'Healthy recipes for everyday cooking', 29.99, 40, 3);

# 3. Customers Table creation....alter
create table customers(
	customer_id int auto_increment primary key,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    email varchar(255) unique not null,
    phone varchar(20),
    address text,
    created_at timestamp default current_timestamp
);

# Insert Customers....
insert into customers (first_name, last_name, email, phone, address)
values('John', 'Due', 'john.doe@email.com', '123-456-7890', '123 Main St, New York, NY'),
('Jane', 'Smith', 'jane.smith@email.com', '123-456-7891', '456 Oak Ave, Los Angeles, CA'),
('Mike', 'Johnson', 'mike.johnson@email.com', '123-456-7892', '789 Pine Rd, Chicago, IL'),
('Sarah', 'Wilson', 'sarah.wilson@email.com', '123-456-7893', '321 Elm St, Miami, FL');

# 4. Orders Table creation....
create table orders(
	order_id int auto_increment primary key,
    customer_id int not null,
    order_date timestamp default current_timestamp,
    total_amount decimal(10, 2) not null check(total_amount >= 0),
    status enum('pending', 'processing', 'shipped', 'delivered', 'cancelled') default 'pending',
    shipping_address text,
    foreign key(customer_id) references customers(customer_id) on delete cascade
);

# Insert Orders....
insert into orders (customer_id, total_amount, status, shipping_address)
values(1, 749.98, 'delivered', '123 Main St, New York, NY'),
(2, 149.98, 'processing', '456 Oak Ave, Los Angeles, CA'),
(3, 169.97, 'shipped', '789 Pine Rd, Chicago, IL'),
(1, 39.99, 'pending', '123 Main St, New York, NY'),
(4, 209.97, 'delivered', '321 Elm St, Miami, FL');

# 5. Order Items Tabel creation....
create table order_items(
	order_item_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    unit_price decimal(10, 2) not null check (unit_price >= 0),
    foreign key (order_id) references orders(order_id) on delete cascade,
    foreign key (product_id) references products(product_id) on delete cascade,
    unique key (order_id, product_id) # Prevents duplicate products in same order
);

# Insert Order Items....
insert into order_items (order_id, product_id, quantity, unit_price)
values(1, 1, 1, 699.99), # Order 1; Smartphone X
(1, 3, 2, 24.99),        # Order 1: 2 Cotton T-Shirts
(2, 2, 1, 199.99),       # Order 2: Wireless Headphones (corrected price)
(2, 6, 1, 39.99),        # Order 2: Laptop Stand (corrected price)
(3, 4, 1, 49.99),        # Order 3: Programming Book
(3, 8, 1, 29.99),        # Order 3: Cookbook
(3, 3, 3, 24.99),        # Order 3: 3 Cotton T-Shirts
(4, 6, 1, 39.99),        # Order 4: Laptop Stand
(5, 5, 1, 89.99),        # Order 5: Coffee Maker
(5, 2, 1, 199.99),       # Order 5: Wireless Headphones (corrected price)
(5, 7, 1, 59.99);        # Order 5: Jeans