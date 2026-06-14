CREATE DATABASE IF NOT EXISTS sales_project;
USE sales_project;



CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);



INSERT INTO customers VALUES
(1, 'Rahul Sharma', 'Mumbai', 'India'),
(2, 'Priya Patel', 'Ahmedabad', 'India'),
(3, 'Amit Verma', 'Delhi', 'India'),
(4, 'Sneha Iyer', 'Chennai', 'India'),
(5, 'Rohan Mehta', 'Pune', 'India'),
(6, 'Neha Gupta', 'Bangalore', 'India'),
(7, 'Vikram Singh', 'Jaipur', 'India'),
(8, 'Ananya Das', 'Kolkata', 'India'),
(9, 'Karan Malhotra', 'Hyderabad', 'India'),
(10, 'Pooja Nair', 'Kochi', 'India');

INSERT INTO products VALUES
(1, 'Wireless Earbuds', 'Electronics', 1299.00),
(2, 'Yoga Mat', 'Fitness', 599.00),
(3, 'Face Serum', 'Skincare', 849.00),
(4, 'Protein Powder', 'Supplements', 1799.00),
(5, 'Running Shoes', 'Footwear', 2499.00),
(6, 'Smart Watch', 'Electronics', 3999.00),
(7, 'Resistance Bands', 'Fitness', 399.00),
(8, 'Moisturizer SPF50', 'Skincare', 649.00),
(9, 'Whey Protein Bar', 'Supplements', 299.00),
(10, 'Casual T-Shirt', 'Fashion', 499.00);

INSERT INTO orders VALUES
(1,  1, 6, 1, '2024-01-05'),
(2,  2, 1, 2, '2024-01-12'),
(3,  3, 4, 1, '2024-01-20'),
(4,  4, 5, 1, '2024-02-03'),
(5,  5, 3, 3, '2024-02-14'),
(6,  6, 2, 2, '2024-02-22'),
(7,  7, 9, 5, '2024-03-01'),
(8,  8, 6, 1, '2024-03-10'),
(9,  9, 10, 4, '2024-03-18'),
(10, 10, 7, 3, '2024-03-25'),
(11, 1, 4, 2, '2024-04-02'),
(12, 2, 8, 1, '2024-04-09'),
(13, 3, 1, 1, '2024-04-15'),
(14, 4, 9, 6, '2024-04-20'),
(15, 5, 5, 1, '2024-05-01'),
(16, 6, 6, 2, '2024-05-08'),
(17, 7, 3, 2, '2024-05-19'),
(18, 8, 4, 1, '2024-05-27'),
(19, 9, 2, 1, '2024-06-04'),
(20, 10, 1, 3, '2024-06-11');



Q1: Total Revenue
SELECT 
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;

Q2: Revenue by Category
SELECT 
    p.category,
    SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

Q3: Top 5 Products by Revenue
SELECT 
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 5;

Q4: Top 5 Customers by Spending
SELECT 
    c.customer_name,
    c.city,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 5;

Q5: Montly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(o.quantity * p.price) AS monthly_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY month; 