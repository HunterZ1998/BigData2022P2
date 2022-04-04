USE SCHEMA yesql_sales.raw;

-- create file format object
CREATE OR REPLACE FILE FORMAT csv_format_vertical_bar
  type = 'CSV'
  field_delimiter = '|'
  skip_header = 1;

CREATE OR REPLACE FILE FORMAT csv_format_comma
  type = 'CSV'
  field_delimiter = ','
  skip_header = 1;