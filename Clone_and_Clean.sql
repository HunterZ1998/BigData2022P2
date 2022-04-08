--# Curated
USE yesql_sales;
CREATE OR REPLACE SCHEMA curated;
USE schema curated;
CREATE OR REPLACE TABLE yesql_sales.curated.customers CLONE yesql_sales.raw.customers;
CREATE OR REPLACE TABLE yesql_sales.curated.employees CLONE yesql_sales.raw.employees;
CREATE OR REPLACE TABLE yesql_sales.curated.products CLONE yesql_sales.raw.products;
CREATE OR REPLACE TABLE yesql_sales.curated.sales CLONE yesql_sales.raw.sales;
USE SCHEMA curated;

--# Change column names
ALTER TABLE sales RENAME COLUMN salespersonid to employeeid;

--# Drop duplicates 
insert overwrite into customers
SELECT * FROM customers GROUP BY customerid, firstname, middleinitial, lastname;

--# Remove unreasonable middle inital 
UPDATE employees SET middleinitial = NULL WHERE middleinitial = '\'';

--#Capitalize initials
insert overwrite into employees
select employeeid, initcap(firstname), initcap(middleinitial), initcap(lastname), initcap(region) from employees;
insert overwrite into customers
select customerid, initcap(firstname), initcap(middleinitial), initcap(lastname) from customers;

--#Assign Primary/Foreign Keys
ALTER TABLE customers ADD PRIMARY KEY (customerid);
ALTER TABLE employees ADD PRIMARY KEY (employeeid);
ALTER TABLE products ADD PRIMARY KEY (productid);
ALTER TABLE sales ADD PRIMARY KEY (orderid);
ALTER TABLE sales ADD FOREIGN KEY (employeeid) REFERENCES employees(employeeid);  
ALTER TABLE sales ADD FOREIGN KEY (customerid) REFERENCES customers(customerid);  
ALTER TABLE sales ADD FOREIGN KEY (productid) REFERENCES products(productid); 
