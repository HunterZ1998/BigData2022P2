USE SCHEMA yesql_customers.raw;

COPY INTO customers
  FROM @customers_s3_stage
  pattern='.*Customers.*.csv'
  ON_ERROR = CONTINUE;