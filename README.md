# CSCI 5751 Project 2 - Snowflake POC

Group: yeSQL

Slack Channel: [yeSQL](https://umndataspring2022.slack.com/archives/C02V04QB4F9)

Team members: 
- John Carruth
- Yuchuan Huang
- Sam Walczak
- Hexuan Zhang

Instruction: [Project 2 – Snowflake POC](https://drive.google.com/file/d/18eDxHup4DcRabKuPZ-gJcgGCNsvFwjtj/view?usp=sharing)

**Table of Contents**
- [CSCI 5751 Project 2 - Snowflake POC](#csci-5751-project-2---snowflake-poc)
  - [Test](#test)
    - [1. Set Up](#1-set-up)
    - [2. Run test files in order](#2-run-test-files-in-order)
    - [3. Removal Script](#3-removal-script)
  - [Notes (according to instruction)](#notes-according-to-instruction)
    - [Deliverable 2: Data load, Database, Tables, Views](#deliverable-2-data-load-database-tables-views)
      - [Step 1: Get and Load Raw Data](#step-1-get-and-load-raw-data)
      - [Step 2: Prepare Data for Business Consumption.](#step-2-prepare-data-for-business-consumption)
        - [1. Raw data quality issue](#1-raw-data-quality-issue)
        - [2. Create `curated` schema](#2-create-curated-schema)
        - [3. Do data cleaning](#3-do-data-cleaning)
        - [4. Create views](#4-create-views)
    - [Deliverable 3: Materialized Views, Clustering, Run Script, Drop Script, Documentation](#deliverable-3-materialized-views-clustering-run-script-drop-script-documentation)
      - [1. Give two specific use cases where clustering and materialized views may be beneficial to the consumption of the sales data.](#1-give-two-specific-use-cases-where-clustering-and-materialized-views-may-be-beneficial-to-the-consumption-of-the-sales-data)
      - [2. Removal script.](#2-removal-script)
      - [3. ReadMe.](#3-readme)

## Test
### 1. Set Up
> Please make sure you have a ready-to-use CLI client [SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql.html). **No** configuration is required for SnowSQL. You will use a testing user `tester` with **Key Pair Authentication** to run the tests. Run all following commands in **terminal**.

1. Clone Github repository.
```
git clone https://github.com/HunterZ1998/BigData2022P2.git
```

2. Change directory to Github repo. (**Please run all following commands in the directory `<path>/BigData2022P2`**)
```
cd BigData2022P2
```

### 2. Run test files in order
1. Create database.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_database.sql
```
Expected output:
> Database YESQL_SALES successfully created.

2. Create schema.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_schema.sql
```
Expected output:
> Schema RAW successfully created.

3. Create table.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_table.sql
```
Expected output:
> Table CUSTOMERS successfully created.
> 
> Table EMPLOYEES successfully created.
> 
> Table PRODUCTS successfully created.
> 
> Table SALES successfully created.

4. Create file format object then create stage.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_file_format_object.sql -f create_stage.sql
```
Expected output:
> File format CSV_FORMAT_VERTICAL_BAR successfully created.
> 
> File format CSV_FORMAT_COMMA successfully created.
> 
> Stage area CUSTOMERS_S3_STAGE successfully created.
> 
> Stage area EMPLOYEES_S3_STAGE successfully created.
> 
> Stage area PRODUCTS_S3_STAGE successfully created.
> 
> Stage area SALES_S3_STAGE successfully created.

5. Load data.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f load_data.sql
```
Expected output:
> | file                                   | status | rows_parsed | rows_loaded | error_limit | errors_seen |
> |----------------------------------------|--------|-------------|-------------|-------------|-------------|
> | s3://seng5709/customers/Customers2.csv | LOADED | 19760       | 19760       | 1           | 0           |
> | s3://seng5709/employees/Employees2.csv | LOADED | 23          | 23          | 1           | 0           |
> | s3://seng5709/products/Products.csv    | LOADED | 504         | 504         | 1           | 0           |
> | s3://seng5709/sales/Sales2.csv         | LOADED | 6715221     | 6715221     | 1           | 0           |

6. Create `curated` schema, clean data, and add primary, foreign key to the data.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f Clone_and_Clean.sql
```
Expected output:
> Schema CURATED successfully created.
> 
> Table CUSTOMERS successfully created.
> 
> Table EMPLOYEES successfully created.
> 
> Table PRODUCTS successfully created.
> 
> Table SALES successfully created.
> 
> number of rows inserted: 19759
> 
> number of rows inserted: 23
> 
> number of rows inserted: 19759

7. Create views in `curated` schema.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_views_question4.sql
```
Expected output:
> View CUSTOMER_MONTHLY_SALES_2019_VIEW successfully created.
> 
> View TOP_TEN_CUSTOMERS_AMOUNT_VIEW successfully created.
> 
> View PRODUCT_SALES_VIEW successfully created.


### 3. Removal Script
Run this command in terminal to remove the whole `yesql` database. 
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f remove_all.sql
```
Expected output:
> YESQL_SALES successfully dropped.

## Notes (according to instruction)

### Deliverable 2: Data load, Database, Tables, Views
#### Step 1: Get and Load Raw Data
See sql files and commands in [Run test files in order (1-5)](#2-run-test-files-in-order).

#### Step 2: Prepare Data for Business Consumption.
All tables checked to ensure:
- Unique primary keys (first column of each table)
- Repeat values checked (different ID, same field values)
- All table columns checked for NULL values
- Range of reference ID values in Sales table (to other tables) checked against range of IDs in those tables (secondary keys)
- Sales table quantity column was checked for zero or negative valued entries
- Products table prices column was checked for zero or negative valued entries (48 products with price = 0, left in table to track inventory)

##### 1. Raw data quality issue
(1) Problem: Mis-spelled column reference: Sales.SalesPersonID refers to the column EmployeeID in the Employees table.
  Solution: Changed column name Sales.SalesPersonID to EmployeeID.
(2) Problem: In the Employees table, the employee associated with EMPLOYEEID = 15, had the middle initial input as an apostrophe.
  Solution: Enforce names must include at least one letter. EMPLOYEEID = 15 middle initial changed to NULL. 
(3) Problem: Time zone of imported data unknown
  Solution: No solution, as we do not know the origin time zone we cannot convert to UTC.
(4) Problem: Case of STRING columns inconsistent (for example: could lead to alex and Alex being counted as different entries)
  Solution: Capitalize first letter of all STRING field entries (except Products as they could be case sensitive)

##### 2. Create `curated` schema
See sql file and command in [Run test files in order (6)](#2-run-test-files-in-order).

##### 3. Do data cleaning
See sql file and command in [Run test files in order (6)](#2-run-test-files-in-order).

##### 4. Create views
See sql file and command in [Run test files in order (7)](#2-run-test-files-in-order).

### Deliverable 3: Materialized Views, Clustering, Run Script, Drop Script, Documentation

#### 1. Give two specific use cases where clustering and materialized views may be beneficial to the consumption of the sales data.

(1) Using materialized views could be beneficial when there is a sub-query that is used a lot by many people in many queries, but the sub-query itself is expensive to run. In this case, a materialized view can be created for this particular sub-query. Therefore, any query involving this sub-query can start from the materialized view, instead of executing from scratch. 

A use case of using materialized views in this dataset is: the company wants to have a deep insight about its business in the north region. It wants to have three different reports on low-priced (0-100), mid-priced (100-500) and high-priced (>500) products sales in the north region. 

The data about product sales is in the `sales` table, while the information about region is only in the `employees` table, and the information about price is only in the `product` table. 

An example set of queries without the materialized view could be:
```
SELECT *
FROM (
    SELECT S.*, E.*, P.*
    FROM sales S, employee E, product P
    WHERE E.region = 'North' AND S.employeeID = E.employeeID AND S.productID = P.productID
) north_sale
WHERE north_sale.price > 0 AND north_sale.price <= 100;

SELECT *
FROM (
    SELECT S.*, E.*, P.*
    FROM sales S, employee E, product P
    WHERE E.region = 'North' AND S.employeeID = E.employeeID AND S.productID = P.productID
) north_sale
WHERE north_sale.price > 100 AND north_sale.price <= 500;

SELECT *
FROM (
    SELECT S.*, E.*, P.*
    FROM sales S, employee E, product P
    WHERE E.region = 'North' AND S.employeeID = E.employeeID AND S.productID = P.productID
) north_sale
WHERE north_sale.price > 500;
```

In this set of queries, the inner sub-query is expensive as it joins three tables and it is executed from scratch for every query. By using the materialized view, the result will be cached for the inner sub-query and it can be used for any later queries.  An example of using materialized view is shown below. 

```
CREATE MATERIALIZED VIEW north_sale_mv
    SELECT S.*, E.*, P.*
    FROM sales S, employee E, product P
    WHERE E.region = 'North' AND S.employeeID = E.employeeID AND S.productID = P.productID;

SELECT * FROM north_sale_mv WHERE north_sale.price > 0 AND north_sale.price <= 100;
SELECT * FROM north_sale_mv WHERE north_sale.price > 100 AND north_sale.price <= 500;
SELECT * FROM north_sale_mv WHERE north_sale.price > 500;
```

Reference: [Working with Materialized Views](https://docs.snowflake.com/en/user-guide/views-materialized.html)

(2) Using clustering could be beneficial when there is lot of selective queries on a particular field on a big table. If the table is clustered on the field, then Snowflake can easily prune a lot of the micro-partitions that do not have the desired value. On the contrary, if the table is not clustered on the field, the desired value may scatter across the micro-partitions, so Snowflake must look into every micro-partition to find the value. 

A use case of using clustering in this dataset is: the company always needs to look at the sales records on a single day. It requires to select the sales record on the date. An example of such query could be:
```
SELECT *
FROM sales
WHERE to_date(Date) = '2020-01-01';

SELECT *
FROM sales
WHERE to_date(Date) = '2020-01-02';

...
```

If the table is not clustered on `Date`, the record on 2020-01-01 could exist on any micro-partition, so Snowflake must scan every micro-partition to get the result. If the table is clustered on `Date`, Snowflake can easily know if a micro-partition contains records on 2020-01-01 without going into the partition. This will boost the performance. 

Reference: [Clustering Keys & Clustered Tables](https://docs.snowflake.com/en/user-guide/tables-clustering-keys.html)

#### 2. Removal script.
See sql file and command in [Removal Script](#3-removal-script).

#### 3. ReadMe.
Please follow the section [Run test files in order](#2-run-test-files-in-order) to run the tests. 
