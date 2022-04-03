USE SCHEMA yesql.raw;


CREATE OR REPLACE TABLE customers (
    CustomerID INT ,
    FirstName VARCHAR ,
    MiddleInitial VARCHAR ,
    LastName VARCHAR
);

CREATE OR REPLACE TABLE employees (
    EmployeeID INT ,
    FirstName VARCHAR ,
    MiddleInitial VARCHAR ,
    LastName VARCHAR ,
    Region VARCHAR
);

CREATE OR REPLACE TABLE products (
    ProductID INT ,
    Name VARCHAR ,
    Price DECIMAL
);

CREATE OR REPLACE TABLE sales (
    OrderID INT ,
    SalesPersonID INT ,
    CustomerID INT ,
    ProduceID INT ,
    Quantity INT ,
    Date TIMESTAMP
);