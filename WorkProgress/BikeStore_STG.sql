
CREATE DATABASE BikeStore_STG;
GO

USE BikeStore_STG;
GO

-- STAGING TABLES

-- Brands
CREATE TABLE STG_brands (
    brand_id INT,
    brand_name NVARCHAR(100)
);
GO


-- Categories
CREATE TABLE STG_categories (
    category_id INT,
    category_name NVARCHAR(100)
);
GO


-- Customers
CREATE TABLE STG_customers (
    customer_id INT,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    phone NVARCHAR(50),
    email NVARCHAR(150),
    street NVARCHAR(255),
    city NVARCHAR(100),
    [state] NVARCHAR(50),
    zip_code NVARCHAR(20)
);
GO


-- Stores
CREATE TABLE STG_stores (
    store_id INT,
    store_name NVARCHAR(100),
    phone NVARCHAR(50),
    email NVARCHAR(150),
    street NVARCHAR(255),
    city NVARCHAR(100),
    [state] NVARCHAR(50),
    zip_code NVARCHAR(20)
);
GO


-- Staffs
CREATE TABLE STG_staffs (
    staff_id INT,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    email NVARCHAR(150),
    phone NVARCHAR(50),
    active INT,
    store_id INT,
    manager_id NVARCHAR(50) NULL
);
GO


-- Products
CREATE TABLE STG_products (
    product_id INT,
    product_name NVARCHAR(1000),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price FLOAT
);
GO


-- Stocks
CREATE TABLE STG_stocks (
    store_id INT,
    product_id INT,
    quantity INT
);
GO


-- Orders
CREATE TABLE STG_orders (
    order_id INT,
    customer_id INT,
    order_status INT,
    order_date DATE,
    required_date DATE,
    shipped_date NVARCHAR(50),
    store_id INT,
    staff_id INT
);
GO


-- Order Items
CREATE TABLE STG_order_items (
    order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price FLOAT,
    discount FLOAT
);
GO