USE SCHEMA yesql_sales.raw;


CREATE OR REPLACE STAGE customers_s3_stage
URL = 's3://seng5709/customers/'
FILE_FORMAT = csv_format_vertical_bar;

CREATE OR REPLACE STAGE employees_s3_stage
URL = 's3://seng5709/employees/'
FILE_FORMAT = csv_format_comma;

CREATE OR REPLACE STAGE products_s3_stage
URL = 's3://seng5709/products/'
FILE_FORMAT = csv_format_vertical_bar;

CREATE OR REPLACE STAGE sales_s3_stage
URL = 's3://seng5709/sales/'
FILE_FORMAT = csv_format_vertical_bar;