-- Day 13  05/08/2026

-- window function

-- 1) row_number()
-- 2) rank()
-- 3) dense_rank()
-- 4) lag()
-- 5) lead() 


-- 1) row_number 

select emp_no, salary,
row_number() over() as row_num
from salaries;


select emp_no, salary,
row_number() over(partition by emp_no) as row_num
from salaries;

select emp_no, salary,
row_number() over(partition  by emp_no order by salary desc) as row_num
from salaries;

select a.emp_no,a.salary,a.row_num
from
(select emp_no, salary,
row_number() over(partition by emp_no order by salary desc) as row_num
from salaries)a
where a.row_num = 1;

-- find the second highest salary for each employees

select a.emp_no,a.salary,a.row_num
from
(select emp_no, salary,
row_number() over(partition by emp_no order by salary desc) as row_num
from salaries)a
where a.row_num = 2;

-- max 
select emp_no, max(salary) as highest_salary
from salaries
group by emp_no;

-- find the nth highest salary from salaries table
select * from salaries 
order by salary desc
limit 1 offset 1;




-- find the nth highest salary from salaries table without using limit and offset

select emp_no,salary
from
(select emp_no,salary,
row_number() over(order by salary desc) as row_num
from salaries) a
where a.row_num = 2;


-- 2) rank() and dense_rank()


 -- rank()
 
select emp_no, salary,
rank() over(partition by emp_no order by salary desc)as r_no
from salaries
where emp_no =  11839; 
 



select a.emp_no,a.salary,a.d_rank_num
from
(select emp_no, salary,
dense_rank() over(partition by emp_no order by salary desc) as d_rank_num
from salaries)a
where a.d_rank_num = 2;


-- dense_rank() and -- rank()
select * from salaries
where emp_no = 11729;

select emp_no, salary,
rank() over(partition by emp_no order by salary desc)as r_no,
dense_rank() over(partition by emp_no order by salary desc)as d_r_no
from salaries
where emp_no =  11839;


-- dense_rank

select emp_no, salary,
dense_rank() over(partition by emp_no order by salary desc)as d_r_no
from salaries
where emp_no =  11839;


-- lag() & lead()

-- lag()

select emp_no, salary,lag(salary) over(partition by emp_no) as previous_salary,
salary - lag(salary) over(partition by emp_no) as salary_increased_by
from salaries; 


-- lead()

select emp_no, salary,lead(salary) over(partition by emp_no) as next_salary,
lead(salary) over(partition by emp_no) as salary_increased_by
from salaries; 
