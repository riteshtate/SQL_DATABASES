-- joins = when we have to extract data from more that one table 
-- rules -1) relation between table
--       -2) row level operation

-- types of join
-- 1) inner join
-- 2)outer join
--   A) left outer join = all the data from left table and matching data from right table
--   B) right outer join = all the data from right table and common data from left table.
-- 3) cross join
-- 4) self join

select * from employees; ----- 10001---------300024

select * from salaries;  ----- 10001---------201771

select e.emp_no, e.first_name , e.last_name, sum(s.salary) as total_salary
from salaries s join employees e on s.emp_no = e.emp_no
where e.emp_no > 11000
group by e.emp_no
having total_salary > 1200000;


-- extract all the employees record
-- who's salaries records is not present in the salaries table

select e.emp_no, e.first_name, e.last_name, s.salary
from employees e left join salaries s  on s.emp_no = e.emp_no
where salary is null;

-- find the all managers total salary 
select *from dept_manager;

select dm.emp_no, sum(s.salary) as total_salary
from salaries s right join dept_manager dm on s.emp_no = dm.emp_no
group by dm.emp_no;


select dm.emp_no, e.first_name,e.last_name, sum(s.salary) as total_salary  -- error
from salaries s right join dept_manager dm on s.emp_no = dm.emp_no
join employees e on e.emp_no = s.emp_no
group by dm.emp_no;

-- find how many employees working in each departments

select d.dept_no,d.dept_name, count(de.emp_no) as no_of_employees
from dept_emp de join departments d on de.dept_no = d.dept_no
group by d.dept_no
having no_of_employees > 50000
order by no_of_employees desc;

-- extract the total_salary for each department
-- dept_name, total_salary

select d.dept_name, sum(s.salary) as total_salary
from departments d join dept_emp de on d.dept_no = de.dept_no
join salaries s on s.emp_no = de.emp_no
group by d.dept_name;

-- Day 10  -- SELF Join and CROSS Join

CREATE TABLE info (
    emp_no INT,
    emp_name VARCHAR(40),
    manager_no INT
);

insert into info
values (1,'Om',5),(2,'Shiv',4),(3,'Sakshi',1),(4,'Atharva',3),(5,'Rahul',2);

select * from info;

-- SELF JOIN

select a.emp_no, a.emp_name, b.emp_name as manager_name, a.manager_no
from info a join info b  on a.manager_no = b.manager_no;

-- cross join 

select * from departments;

select * from dept_manager;

select * from departments d  join dept_manager dm;


-- CTE

-- Day 11

-- table 1 (1,1,2,null,0,0,0,null)
-- table 2 (1,1,2,2,2,null,null,3,4)
-- inner,left,right,full
-- inner = 7
-- left = 12
-- right = 11
-- full = 16