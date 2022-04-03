# Curated
USE yesql_sales;
CREATE OR REPLACE SCHEMA curated;
CREATE OR REPLACE TABLE yesql_sales.curated.customers CLONE yesql_sales.raw.customers;
CREATE OR REPLACE TABLE yesql_sales.curated.employees CLONE yesql_sales.raw.employees;
CREATE OR REPLACE TABLE yesql_sales.curated.products CLONE yesql_sales.raw.products;
CREATE OR REPLACE TABLE yesql_sales.curated.sales CLONE yesql_sales.raw.sales;
USE SCHEMA curated;

# Change column names
ALTER TABLE sales RENAME COLUMN produceid to productid;
ALTER TABLE sales RENAME COLUMN salespersonid to employeeid;

# Drop duplicates 
insert overwrite into customers
SELECT * FROM customers GROUP BY customerid, firstname, middleinitial, lastname;

#Capitalize initial for region
insert overwrite into employees
select employeeid, initcap(firstname), initcap(middleinitial), initcap(lastname), initcap(region) from employees;