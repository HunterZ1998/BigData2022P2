USE SCHEMA yesql.raw;


COPY INTO customers
FROM @customers_s3_stage
pattern='.*Customers.*.csv';

COPY INTO employees
FROM @employees_s3_stage
pattern='.*Employees.*.csv';

COPY INTO products
FROM @products_s3_stage
pattern='.*Products.*.csv';

COPY INTO sales
FROM @sales_s3_stage
pattern='.*Sales.*.csv';