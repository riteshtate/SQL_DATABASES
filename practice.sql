/*List all customers from Maharashtra using a CTE that selects from the customers table.
Find total sales amount for each customer using a CTE on the sales table, joined with customers to show names.
Show all products in the 'Electronics' category using a CTE, then select from it in the outer query.
Find the total quantity sold for each product using a CTE on sales_items.
List all sales made in January 2025 using a CTE that filters sale_date, then display customer names by joining with customers.
Find customers who live in Pune using a CTE, and show their total number of purchases from sales.
Calculate total revenue per product using a CTE (sum of total_price from sales_items grouped by product_id), joined with products for names.
Find the highest single sale amount using a CTE that selects all sales, then get the MAX(total_amount) from it.
List products priced above 10,000 using a CTE on the products table.
Count how many sales each customer made using a CTE that groups sales by customer_id, then join with customers to show names.*/

-- List all customers from Maharashtra using a CTE that selects from the customers table.

select * from customers;

select customer_id,customer_name,state
 from customers
where state = 'maharashtra';



with stay_maharastra as
(select customer_id,customer_name,state
 from customers
where state = 'maharashtra')
select customer_name from stay_maharastra;

-- Find total sales amount for each customer using a CTE on the sales table, joined with customers to show names.

select * from sales;
select customer_id,sale_id,(total_amount) as total_amount
from sales
where sale_id = customer_id;

  


