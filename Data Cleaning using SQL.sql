select * from messy_indian_dataset
select * from messy_indian_dataset;


-- Handling Missing Values

-- Removing Duplicates

-- Converting Data Types

-- Correcting Inconsistent Data | misspelled , inconsistent capitalization, or inconsistent date formats.

-- Validating Data Integrity |Validate the integrity of data 

-- Handling Outliers

-- Parsing and Extracting Information | Email extraction

-- Data Transformation | Scaling, Normalization, or Encoding Categorical Variables

Q1. Handling Missing Values

-- Find the rows with missing values in any column
select * from messy_indian_dataset where name is null or age is null or gender is null or email is null or phone_number is null
or city is null or state is null or purchase_amount is null or purchase_date is null


-- Find the rows without missing values
select * from messy_indian_dataset
where name is not null and age is not null and gender is not null and email is not null and phone_number is not null
and city is not null and state is not null and purchase_amount is not null and purchase_date is not null

-- Saving Table without null values

create view clean_dataset as (
select * from messy_indian_dataset
where name is not null and age is not null and gender is not null and email is not null and phone_number is not null
and city is not null and state is not null and purchase_amount is not null and purchase_date is not null
)

select * from clean_dataset



-- Filling missing age all with specific values

select round(avg(age), 2) from messy_indian_dataset;
update messy_indian_dataset set age = coalesce(age,(select round(avg(age), 2) from messy_indian_dataset))
select age from messy_indian_dataset

-- Filling all null with specific values
update messy_indian_dataset
set
name = coalesce(name, 'Unknown'),
age = coalesce(age, 0),
gender = coalesce(gender,'Unknown'),
email = coalesce(email, 'Unknown'),
phone_number = coalesce(phone_number, 'Unknown'),
city = coalesce(city,'Unknown'),
state = coalesce(state,'Unknown'),
purchase_amount = coalesce(purchase_amount,00),
purchase_date = coalesce(purchase_date, '2002-10-22')

select * from messy_indian_dataset
alter table messy_indian_dataset rename to messy_data

 

-- Filling null amount with average amount values

select round(avg(purchase_amount),2) from messy_indian_dataset

update messy_indian_dataset set purchase_amount = (select round(avg(purchase_amount),2) from messy_indian_dataset)
where purchase_amount = 0.00

select purchase_amount from messy_indian_dataset




-- Filling null city with most frequent city

select city , count(city) from messy_indian_dataset group by city order by count(city) desc;

update messy_indian_dataset
set city = (select city , count(city) from messy_indian_dataset group by city order by count(city) desc limit 1)
where city = 'Unknown'

select * from messy_indian_dataset


-- Filling null gender with most frequent gender
create view gender as (
select gender, count(gender) as "frequency" from messy_indian_dataset
group by gender
order by frequency desc
limit 1
)

select * from gender

update messy_indian_dataset
set gender = (select gender from gender)
where gender = 'Unknown'



select age, count(age) from messy_indian_dataset group by age order by count(age) desc limit 1;





Q2. -- Removing Duplicates ---------------------------------------------------------------------------------------------

-- Finding only unique rows

select distinct * from messy_indian_dataset

-- Finding unique values based on ID

select id from messy_indian_dataset group by id order by id


-- Finding unique name based on name
select name from messy_indian_dataset group by name order by name



-- Finding unique values based on ID using rank

select * , row_number() over(partition by id order by id) as "rank" from messy_indian_dataset



-- Finding unique values based on multiple columns | Rajesh Patel & Patil






Q3 . Handling Outliler ----------------------------------------------------------------------------------------------------


-- Finding Outlier based on Z-Score

select * ,round(ABS(purchase_amount - avg(purchase_amount) over())/STDDEV(purchase_amount) over(),2) as "z_scoore"
from messy_indian_dataset;

select * , round(ABS(purchase_amount - avg(purchase_amount) over()) / stddev(purchase_amount) over(), 2) as "Z_score"
from messy_indian_dataset;

-- Remove Outlier based on specific Z_score

select * from
(
   select *, 
       round(ABS(purchase_amount - avg(purchase_amount) over()) / stddev(purchase_amount) over(), 2) as "z_score"
   from messy_indian_dataset
)as sub_table 
where sub_table.z_score < 3



Q4. Working with dates ------------------------------------------------------------------------------------------------------

select * from messy_data
-- Add a new column for day, month , and year
alter table messy_data
add column day int,
add column month int,
add column year int;
select * from messy_data



-- Update the new columns with the extracted day, month and year Values

select * from messy_data

UPDATE messy_data
SET day = EXTRACT(DAY FROM purchase_date),
    month = EXTRACT(MONTH FROM purchase_date),
    year = EXTRACT(YEAR FROM purchase_date);

select * from messy_data


-- Add a new column for the day of the week and save day name there

ALTER TABLE messy_data
ADD COLUMN day_of_week VARCHAR(10);


UPDATE messy_data
SET day_of_week = TO_CHAR(purchase_date, 'Day')

select * from messy_data

-- Add a new column for the name of the month and save day name there
alter table messy_data
add column name_of_month varchar(10);

UPDATE messy_data
SET name_of_month = TO_CHAR(purchase_date, 'Month');


select * from messy_data


















































































































































