-- Day 14   6/8/2026
-- case statement
-- CTE


-- case statement


select * from employees;

select emp_no,first_name,last_name,
case 
	when gender='m' then 'male'
	when gender='f' then 'female'
end as gender
from employees;

-- emp_no,first_name,last_num,total_salary,salary_range
-- total_salary > 1200000 then 'high saalary'
-- total_salary > 800000 then 'medi saalary'
-- total_salary > 600000 then 'low saalary'
-- very low salary

select emp_no,sum(salary) as total_salary,
case
	when sum(salary) > 1200000 then 'high salary'
	when sum(salary) > 800000 then 'medium salary'
    when sum(salary) > 600000 then 'low salary'
    else 'very low salary'
end as salary_range
from salaries
group by emp_no;


-- advanced

SELECT 
    emp_no, total_salary, salary_range
FROM
    (SELECT 
        emp_no,
            SUM(salary) AS total_salary,
            CASE
                WHEN SUM(salary) > 1200000 THEN 'high salary'
                WHEN SUM(salary) > 800000 THEN 'medium salary'
                WHEN SUM(salary) > 600000 THEN 'low salary'
                ELSE 'very low salary'
            END AS salary_range
    FROM
        salaries
    GROUP BY emp_no) AS a
    where salary_range = 'medium salary';
    
    
    select e.emp_no,e.first_name,e.last_name, sum(s.salary) as total_salary,
case
	when sum(s.salary) > 1200000 then 'high salary'
	when sum(s.salary) > 800000 then 'medium salary'
    when sum(s.salary) > 600000 then 'low salary'
    else 'very low salary'
end as salary_range
from salaries s join employees e on s.emp_no = e.emp_no
group by e.emp_no;



-- CTE (common table exprassion)

-- find the employees record who's salary is higher than avg_salary of all employees

select avg(salary) as avg_salary
from salaries; --- 63860.4391


with emp_avg_salary as (select avg(salary) as avg_salary
from salaries)
select s.salary,s.emp_no,s.e.avg_salary from salaries s join emp_avg_salary e;  

-- find how many male employees salary records,whos salary is higher than 
-- avg salary - female
-- male emp salary records
 
select avg(s.salary) as avg_salary
from salaries s join employees e on s.emp_no = e.emp_no
where gender = 'f';

select e.emp_no,e.first_name,e.last_name,s.salary,e.gender
from salaries s join employees e on e.emp_no = s.emp_no
where e.gender='m';


 

with male_salary_record as
(select e.emp_no,e.first_name,e.last_name,s.salary,e.gender
from salaries s join employees e on e.emp_no = s.emp_no
where e.gender='m'),
avg_salary_female as (select avg(s.salary) as avg_salary
from salaries s join employees e on s.emp_no = e.emp_no
where gender = 'f')
select count(*) as no_of_male_employees_record from male_salary_record m join avg_salary_female f 
where m.salary > f.avg_salary;


with male_salary_records as
(select e.emp_no,e.first_name,e.last_name,s.salary,e.gender
from salaries s join employees e on e.emp_no = s.emp_no
where e.gender='m'),
f_avg_salary as 
(select avg(s.salary) as avg_salary
from salaries s join employees e on e.emp_no = s.emp_no
where gender = 'f')
select count(*) as no_of_male_records, (select count(*) from male_salary_records) as total_m_records
from male_salary_records m join f_avg_salary f
where m.salary > f.avg_salary;


-- count(*), count(emp_no), count(distinct emp_no)  ------ difference between

-- find how many female employees salary records , who's salary is higher than avg salary off all employees whos has hired before 2000-01-01

-- 1)female employees salary record
-- 2)avg_salary - emp hired before 2000-01-01
     
    
    SELECT e.emp_no,s.salary,e.gender
    FROM salaries s JOIN employees e ON e.emp_no = s.emp_no
    WHERE e.gender = 'F';
    
    select avg(s.salary) as avg_salary
    from employees e join salaries s on e.emp_no = s.emp_no
    where e.hire_date < '2000-01-01';
    
  WITH f_records AS 
	(SELECT e.emp_no,s.salary,e.gender
    FROM salaries s JOIN employees e ON e.emp_no = s.emp_no
    WHERE e.gender = 'F'),
emp_avg_saalry AS
(select avg(s.salary) as avg_salary
    from employees e join salaries s on e.emp_no = s.emp_no
    where e.hire_date < '2000-01-01')
    
SELECT * from f_records f join emp_avg_saalry e 
where f.salary > e.avg_salary;


-- H.W 6/8/2026 ---         DAY 15 

Create database customer_details;
Use customer_details;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50)
);

INSERT INTO customers VALUES
(101,'Amit Sharma','Pune','Maharashtra'),
(102,'Priya Patil','Mumbai','Maharashtra'),
(103,'Rahul Verma','Delhi','Delhi'),
(104,'Sneha Joshi','Pune','Maharashtra'),
(105,'Neha Singh','Nagpur','Maharashtra'),
(106,'Rohit Gupta','Jaipur','Rajasthan'),
(107,'Anjali Kulkarni','Nashik','Maharashtra'),
(108,'Karan Mehta','Ahmedabad','Gujarat');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1,'Laptop','Electronics',60000),
(2,'Mouse','Electronics',800),
(3,'Keyboard','Electronics',1500),
(4,'Mobile','Electronics',25000),
(5,'Table','Furniture',8000),
(6,'Chair','Furniture',3000),
(7,'Printer','Electronics',12000),
(8,'Monitor','Electronics',18000);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

INSERT INTO sales VALUES
(1001,101,'2025-01-05',65000),
(1002,102,'2025-01-10',25800),
(1003,103,'2025-01-15',9000),
(1004,104,'2025-01-20',78000),
(1005,105,'2025-01-22',3000),
(1006,106,'2025-01-25',12000),
(1007,107,'2025-01-28',18000),
(1008,101,'2025-02-01',8000),
(1009,103,'2025-02-05',60000),
(1010,108,'2025-02-10',25000);

CREATE TABLE sales_items (
    sales_item_id INT PRIMARY KEY,
    sale_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    FOREIGN KEY(sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

INSERT INTO sales_items VALUES
(1,1001,1,1,60000,60000),
(2,1001,2,5,800,4000),
(3,1002,4,1,25000,25000),
(4,1002,2,1,800,800),
(5,1003,5,1,8000,8000),
(6,1003,6,1,1000,1000),
(7,1004,1,1,60000,60000),
(8,1004,7,1,12000,12000),
(9,1004,2,5,1200,6000),
(10,1005,6,1,3000,3000),
(11,1006,7,1,12000,12000),
(12,1007,8,1,18000,18000),
(13,1008,5,1,8000,8000),
(14,1009,1,1,60000,60000),
(15,1010,4,1,25000,25000);

-- 1) Display customers whose total purchase amount is greater than ₹50,000 using CTE.
-- 2) Find products costing more than the average product price using CTE.
-- 3) Find customers whose total purchase is greater than the average customer purchase.
-- 4) Find products whose revenue is greater than ₹50,000.
-- 5) Display cities having more than one customer.


select*from customers;
select*from products;
select*from sales;
select*from sales_items;

-- 1) Display customers whose total purchase amount is greater than ₹50,000 using CTE.

select customer_id, sum(total_amount) as total_purchase
from sales
group by customer_id
having total_purchase > 50000;

with total_purchase as 
(select customer_id, sum(total_amount) as total_purchase
from sales
group by customer_id)
select p.customer_id,c.customer_name,p.total_purchase
from customers c join total_purchase p on c.customer_id=p.customer_id
where p.total_purchase > 50000;

-- 2) Find products costing more than the average product price using CTE.

SELECT AVG(unit_price) AS avg_price
FROM products;

WITH AvgPrice AS
(SELECT AVG(unit_price) AS avg_price
FROM products)
SELECT * FROM products p join  AvgPrice a 
WHERE unit_price > avg_price;

-- 3) Find customers whose total purchase is greater than the average purchase of all customer.

select avg(total_amount) as avg_purchase
from sales;

select customer_id , sum(total_amount) as avg_purchase
from sales
group by customer_id;

with avg_customer_purchase as(
select avg(total_amount) as avg_purchase
from sales),

total_purchase as (
select customer_id , sum(total_amount) as total_purchase
from sales
group by customer_id)
select b.customer_id,b.total_purchase,a.avg_purchase from avg_customer_purchase a join total_purchase b
where b.total_purchase > a.avg_purchase;

-- 4) Find products whose revenue is greater than ₹50,000.

with product_revenue as
(select product_id,sum(total_price) as revenue
from sales_items
group by product_id)
select pr.product_id,p.product_name,pr.revenue
from product_revenue pr join products p on pr.product_id=p.product_id
where pr.revenue > 50000;

-- 5) Display cities having more than one customer.

select city, count(customer_id) as customer_count
from customers
group by city
having customer_count > 1;

with customer_count_ as (select city, count(customer_id) as customer_count
from customers
group by city
having customer_count > 1)
select customer_count,city
from customer_count_ 
where customer_count >1;


with customer_count_ as (select city, count(customer_id) as customer_count
from customers
group by city
having customer_count > 1)
select cc.customer_count,c.city
from customer_count_ cc join customers c on c.city=cc.city
where cc.customer_count >1;

-- syntax
-- with table_name1(r1),
-- table_name2(r2)
-- select * from table1 join table2
-- where