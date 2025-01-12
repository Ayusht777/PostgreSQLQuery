-- Create the `users` table with basic user information and constraints
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,                 -- Auto-incrementing primary key for users
    name VARCHAR(50) NOT NULL,             -- User's name (required)
    email VARCHAR(50) NOT NULL UNIQUE,     -- Unique email address (required)
    password VARCHAR(50) NOT NULL,         -- Password with length constraints
    CHECK (char_length(password) BETWEEN 4 AND 8), -- Enforces password length between 4 and 8
    created_at TIMESTAMPTZ DEFAULT NOW()   -- Timestamp of creation, defaults to current time
);

-- Insert a new user into the `users` table
INSERT INTO users (name, email, password)
VALUES ('ayusht', 'ayusthc@mail.com', 'atyus');

-- Create the `products` table to store product details and link to users
CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY,          -- Auto-incrementing primary key for products
    product_name VARCHAR(255) NOT NULL,     -- Name of the product (required)
    product_desc TEXT NOT NULL,             -- Description of the product (required)
    product_price NUMERIC(10,2) NOT NULL,   -- Product price with 2 decimal precision (required)
    product_owner INT REFERENCES users(id), -- Foreign key linking to the `users` table
    created_at TIMESTAMPTZ DEFAULT NOW()    -- Timestamp of creation, defaults to current time
);

-- Insert multiple products into the `products` table
INSERT INTO products (product_name, product_desc, product_price, product_owner)
VALUES 
    ('Car', 'A new BMW car', 400.52, 1),                -- Product owned by user with id 1
    ('SUV', 'A new BMW car', 400.52, 1),                -- Product owned by user with id 1
    ('Bike', 'A high-speed sports bike', 200.00, 3),    -- Product owned by user with id 3
    ('Laptop', 'A high-performance laptop', 1500.99, 1),-- Product owned by user with id 1
    ('Phone', 'The latest smartphone model', 799.49, 3),-- Product owned by user with id 3
    ('Watch', 'A luxury smartwatch', 350.25, 1);        -- Product owned by user with id 1

-- Query products owned by user with id 1 and priced over 100
SELECT * FROM products
WHERE product_owner = 1 AND product_price > 100;

-- Count the total number of products
SELECT COUNT(*) FROM products;

-- Calculate the average price of all products
SELECT AVG(product_price) FROM products;

-- Calculate the sum of all product prices
SELECT SUM(product_price) FROM products;

-- Update all product prices to 100
UPDATE products
SET product_price = 100;

-- Update the price of the product with id 1 to 109
UPDATE products
SET product_price = 109
WHERE product_id = 1;

-- Update product descriptions that mention "BMW"
UPDATE products
SET product_desc = 'new world of BMW'
WHERE product_desc LIKE '%BMW%';

-- Delete all rows from the `products` table (no filters)
DELETE FROM products;

-- Truncate the `products` table to remove all rows without logging each deletion
TRUNCATE TABLE products;

-- Delete products where the name is exactly 'SUV'
DELETE FROM products
WHERE product_name LIKE 'SUV';

-- Delete all products where the name is NOT 'SUV'
DELETE FROM products
WHERE product_name NOT LIKE 'SUV';

-- Create a backup table `products_bkp` with all data from `products`
CREATE TABLE products_bkp
AS
SELECT * FROM products;

-- Create a duplicate table `products_bkp2` with only the structure (no data)
CREATE TABLE products_bkp2
AS
SELECT * FROM products
WHERE 0 = -1;

-- Drop the duplicate table `products_bkp2`
DROP TABLE products_bkp2;
