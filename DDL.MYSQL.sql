-- DDL - Create, alter, drop, rename, truncate

-- 1) create 
use ritesh;

-- 2) alter

-- add column, delete column, rename column, change column data types(modify)
-- add constraints on column

-- add primary key
-- alter table companies add primary key (company_id);

-- add foreign key
-- alter table items add foreign key (company_id) references companies (company_id);

-- add column
-- alter table sales add column gender enum('m','n');

-- rename column
-- alter table customers rename column number_of_complaints to complaints;

-- modify column
-- alter table companies modify column headquarters_phone_number varchar(20); 

-- change column
-- alter table items change column item item_id int;

-- drop column
-- alter table items drop column unit_price ;

-- add unique key
-- alter table customers add unique key (email);

-- drop primary key
-- alter table items drop primary key;

-- drop foreign key 
-- alter table items drop foreign key items_ibfk_1;

-- drop unique key
-- alter table items drop index company_id;



-- 3) drop 
-- drop table tablename;


-- 4) rename
-- alter table oldtablename
-- rename newtablename;


-- 5) truncate 
-- truncate table tablename;




