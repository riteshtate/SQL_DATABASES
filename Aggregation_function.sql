-- Day 7 21/7/2026
-- Aggregate function

-- 1)sum
-- 2)min
-- 3)max
-- 4)avg
-- 5)count

-- user-defined and pre-defined
-- 10,20,30,40,50
-- sum = 150
-- min = 10
-- max = 50
-- avg = 150/5
-- count = 5


-- own database create

create database student_database;
use student_database;

CREATE TABLE student_info (
    admission_id INT,
    std_id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    course VARCHAR(20),
    fees DECIMAL(10.2)
);

insert into student_info
values(1,101,'ritesh','tate','python',15000.00);

insert into student_info
values(2,102,'raju','patil','SQL',12000.00),
      (3,103,'chandu','waghmare','python',15000.00),
      (4,104,'vedant','shendge','SQL',16000.00),
      (5,102,'raju','patil','python',12000.00),
      (6,103,'chandu','waghmare','SQL',12000.00),
      (7,104,'vedant','shendge','python',16000.00),
      (8,101,'ritesh','tate','SQL',15000.00);
      
select*from student_info;

-- find the total fees generated
use employees;
select sum(fees)
from student_info;

select sum(fees) as total_fees
from student_info;

select max(fees) as maximum_fees
from student_info;

select avg(fees) as aversge_fees
from student_info;

select count(fees)
from student_info;

select std_id, sum(fees) as total_fees
from student_info
where std_id=101;

use student_database;
select * from student_info;
-- find the total_fees paid by each statement
select std_id, first_name, sum(fees) as total_fees
from student_info
group by std_id
having total_fees >= 30000;

select std_id, count(course) as no_of_courses
from student_info
group by std_id;

-- find the total fees paid by each student who std_id is higher than 102
select std_id, sum(fees) as total_fees
from student_info
where std_id >= 102
group by std_id;

-- find the total fees paid by each student who std_id is higher than 102
-- and total_fees higherthan 15000

select std_id , sum(fees) as total_fees
from student_info
where std_id > 102 
group by std_id;

SELECT std_id, first_name, last_name, SUM(fees) AS total_fees
FROM student_info
WHERE std_id > 102
GROUP BY std_id, first_name, last_name;

use employees;

select*from salaries;

select max(salary) as highest_salary
from salaries;


-- find the highest_salary for each employees
select emp_no,max(salary) as highest_salary
from salaries
group by emp_no;

-- find the highest_salary for each employees
-- whos emp_no is higher than 11000
-- and highest_salary higher 85000
use employees;

select emp_no, max(salary) as highest_salary
from salaries
where emp_no > 11000
group by emp_no
having highest_salary > 85000;

select emp_no, max(salary) as highest_salary
from salaries
where emp_no > 11000
group by emp_no
having highest_salary > 85000
order by highest_salary desc;

select emp_no, max(salary) as highest_salary
from salaries
where emp_no > 11000
group by emp_no
having highest_salary > 85000
order by highest_salary desc
limit 4;

-- sql query writing sequence
-- select, from, where, group by, having, order by, limit.

-- execution sequence
-- from, where, group by, having, select, order by, limit
 