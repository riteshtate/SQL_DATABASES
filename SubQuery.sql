-- Day 12     04/08/2026
-- subquery

-- it is a query which is inside another query 

-- find the employees who's salaries is higher than avg salary of all employees

select sum(salary) from salaries;

select salary
from salaries
where emp_no = (select sum(salary) from salaries);

 select emp_no,salary
 from salaries 
 where salary > (select emp_no ,avg(salary) as avg_salary from salaries);
 
 
 
-- types of subquery

-- 1) single row
-- 2) multiple row
-- 3) scalar
-- 4) correlated
-- 5) nested

-- find the employees detail  (emp_no,first_name,last_name,gender)of all manager

select emp_no,first_name,last_name,gender
from employees
where emp_no in (select emp_no from dept_manager);

-- extract all records from employees table                   ------------------errrrr
-- who's first_name is parto,saniya, chirstian,georgi

select * from employees where first_name in('parto','saniya', 'chirstian','georgi');

-- find the employees details who's working in department d001,d002,d003

select emp_no, first_name, last_name,gender
from employees
where emp_no in ( select emp_no from  dept_emp where dept_no in ('d001','d002','d003'));

select emp_no, first_name, last_name,gender
from employees e
where exists( select *from  dept_emp de where dept_no in ('d001','d002','d003')
and e.emp_no = de.emp_no);


-- emp_no,first_name,last_name,gender
-- manager

select emp_no,first_name,last_name,gender
from employees
where emp_no in (select emp_no from dept_manager
where emp_no in (select emp_no from titles where title = 'manager'));    -- nested subquery

-- insert,update,
-- H.W 

create database subquery;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments VALUES
(10,'HR'),
(20,'IT'),
(30,'Sales'),
(40,'Finance');

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender CHAR(1),
    salary DECIMAL(10,2),
    dept_id INT,
    manager_id INT,
    city VARCHAR(50),
    FOREIGN KEY(dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
(101,'Amit','M',60000,20,NULL,'Pune'),
(102,'Priya','F',45000,10,101,'Mumbai'),
(103,'Rahul','M',70000,20,101,'Pune'),
(104,'Sneha','F',50000,30,103,'Delhi'),
(105,'Karan','M',35000,30,103,'Mumbai'),
(106,'Neha','F',80000,40,101,'Pune'),
(107,'Rohit','M',55000,20,103,'Nagpur'),
(108,'Pooja','F',30000,10,102,'Nashik'),
(109,'Vikas','M',90000,40,101,'Delhi'),
(110,'Anjali','F',65000,30,103,'Pune');

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    dept_id INT,
    budget DECIMAL(12,2),
    FOREIGN KEY(dept_id) REFERENCES departments(dept_id)
);

INSERT INTO projects VALUES
(1,'ERP',20,500000),
(2,'Recruitment',10,150000),
(3,'CRM',30,300000),
(4,'Audit',40,250000),
(5,'Website',20,400000);

CREATE TABLE employee_project (
    emp_id INT,
    project_id INT,
    PRIMARY
KEY(emp_id,project_id),
    FOREIGN KEY(emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY(project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_project VALUES
(101,1),
(103,1),
(107,5),
(102,2),
(108,2),
(104,3),
(105,3),
(110,3),
(106,4),
(109,4);




-- 1) find Employees earning more than average salary

SELECT emp_name, salary
FROM employees
WHERE salary > ( SELECT AVG(salary) FROM employees);


-- 2) find Employee(s) getting maximum salary
SELECT emp_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);


-- 3) find Employees working in departments that have projects

SELECT emp_name, dept_id
FROM employees
WHERE dept_id IN (SELECT dept_id FROM projects);


-- 4) Employees whose department has no project

SELECT emp_name, dept_id
FROM employees
WHERE dept_id NOT IN (SELECT dept_id FROM projects);


-- 5) Employees working on projects with budget > 3,00,000

SELECT emp_name FROM employees
WHERE emp_id IN (SELECT emp_id FROM employee_project
WHERE project_id IN (SELECT project_id FROM projects WHERE budget > 300000));

