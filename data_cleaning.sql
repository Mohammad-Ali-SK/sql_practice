-- READE TABLE

select * from students limit(3)

-- DELETE TABLE

delete from students
where student_id = 1

-- CREATE TABLE


CREATE TABLE employees(
emp_id SERIAL PRIMARY KEY,
fname VARCHAR(100) NOT NULL,
lname VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
dept VARCHAR(50),
salary DECIMAL(10,2) DEFAULT 30000.00,
hire_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- READ

select * from employees



-- INSERT INTO


insert into employees
values(1,'Sumon','sk','sumon09@gmail.com','IT', 60000.00,'2020-08-22');

insert into employees(fname,lname,email,dept)
values
('roj','sk','rojsk09@gmail.com','IT');

insert into employees(fname,lname,email,dept)
values
('Rup','sk','rupsk09@gmail.com','HR');

insert into employees(emp_id,fname,lname,email,dept,salary,hire_date)
values
(2, 'Raj','Sing','rajsing09@gmail.com','Sales', 55000.00,'2023-11-24');


select * from employees

-- UPDATE

update employees
set lname = 'Sultana'
where emp_id = 4

-- IN

select * from employees where dept in('IT','Sales')

-- BETWEEN

select * from employees where salary between 50000 and 60000;

-- DISTINCT

select distinct dept from employees

-- ORDER BY

select * from employees order by emp_id

select round(avg(salary),2) from employees

select emp_id, fname, salary from employees where salary < (select avg(salary) from employees)

-- GROUP BY

select dept, count(dept) from employees group by dept

select dept, sum(salary) from employees group by dept

-- Section ---           **6****
-- String Function
-- Concat , concat_ws
-- SUBSTR
-- LEFT, RIGHT
-- LENGTH
-- UPPER, LOWER
-- TRIM, LTRIM, RTRIM
-- REPLACE
-- POSITION
-- STRING_AGG

-- CONCAT
select fname, lname, concat(fname,lname) AS Fullname from employees;

-- CONCAT_WS
select fname, lname, concat_ws(' ',fname,lname) as fullname from employees;

-- SUBSTR
select fname , substr(fname,1,4) as shorname from employees

select fname, lname , concat_ws(' ',fname,lname) from employees

select substr('February',1,3) as month_name

-- REPLACE FUNCTION

select replace('Hey Buddy','Hey', 'Hello')

select replace(dept,'IT','Information Tecnology') from employees

-- REVERSE

select reverse('Hello World')

-- LENGTH

select fname, length(fname) from employees

-- UPPER
select fname, upper(fname) from employees

-- LOWER
select lower(fname) from employees

-- LEFT / RIGHT
select left('Mohammad', 3)
select right('Mohammad',4)

-- TRIM
select trim('  amit bahi  ')

-- POSITION
select position('on' in 'Nation')


-- EXCERSIZE

select concat_ws(':',emp_id,concat_ws(' ',fname,lname),dept,salary) from employees
where emp_id = 1

-- 1. Hight salary by oder
select * from employees order by salary desc;

-- 2. Find of employees of each deperment
select dept, count(dept) from employees group by dept

select sum(salary) from employees where dept = 'Marketing'
select * from employees

select dept, round(avg(salary),2) from employees group by dept

select max(salary) from employees

select * from employees where salary = (select max(salary) from employees)



-- Section 7 ------------------------------------------------------------------------------------------------------------------------
-- Altering Tables

select * from persons

-- ADD COLUMN

ALTER TABLE persons
ADD COLUMN city varchar(50);

-- DELETE COlUMN
ALTER TABLE persons
DROP COLUMN city


-- Rename Column
alter table persons
rename column name to fname;

select * from persons

-- Rename Table
-- alter table persons
-- rename to customers
alter table customers
rename to persons

-- How to modify a column ??

alter table persons
alter column fname
set data type varchar(100)

select * from persons




-- Check // Constraint----------------------------------------------------------------------------------------------

-- Like phone number check

alter table persons
add column
     mob2 varchar(50);

select * from persons

insert into persons(mob2)
values (123456780);
select * from persons



-- CASE -----------------------------------------------------------------------

select * from employees

select 
CASE
   WHEN  salary >= 50000 THEN 'High'
   ELSE 'Low'
END AS sal_cat,count(emp_id)
FROM
    employees
	group by sal_cat



select fname, salary,
case
when salary > 0 then round(salary*.10)
end as bonus
from employees


-- Section 8 -----------------------------------------------------------------------------------
-- Relationship


select * from customer

select * from employees

select e.emp_id,e.fname,e.salary,e.dept from employees as e
where e.dept = 'IT' and e.salary = (select max(salary) from employees as e where e.dept = 'IT')

-- Make user defined function------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION dept_max_sal_emp1(dept_name VARCHAR)
returns table(emp_id INT,fname VARCHAR, salary NUMERIC)
AS $$
BEGIN
RETURN QUERY
select e.emp_id, e.fname, e.salary from employees as e
where e.dept = dept_name AND salary = (select MAX(salary) from employees as e where e.dept = dept_name);
END
$$ LANGUAGE plpgsql;


select * from dept_max_sal_emp1('HR')





























































