USE SCHEMA yesql_customers.raw;

CREATE OR REPLACE STAGE customers_s3_stage
URL = 's3://seng5709/customers/'
FILE_FORMAT = ( TYPE = CSV, FIELD_DELIMITER = '|');