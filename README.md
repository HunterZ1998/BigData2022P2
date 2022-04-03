# CSCI 5751 Project 2 - Snowflake POC

Group: yeSQL

Slack Channel: [yeSQL](https://umndataspring2022.slack.com/archives/C02V04QB4F9)

Team members: 
- John Carruth
- Yuchuan Huang
- Sam Walczak
- Hexuan Zhang.

Instruction: [Project 2 – Snowflake POC](https://drive.google.com/file/d/18eDxHup4DcRabKuPZ-gJcgGCNsvFwjtj/view?usp=sharing)

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

2. Create schema.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_schema.sql
```

3. Create table.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_table.sql
```

4. Create file format object then create stage.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f create_file_format_object.sql -f create_stage.sql
```

5. Load data.
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f load_data.sql
```

6. TODO:

### 3. Removal Script
Run this command in terminal to remove the whole `yesql` database. 
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f remove_all.sql
```

## Notes (according to instruction)

### Deliverable 2: Data load, Database, Tables, Views
#### Step 1: Get and Load Raw Data
See sql files and commands in [Run test files in order (1-5)](#2-run-test-files-in-order).

#### Step 2: Prepare Data for Business Consumption.
##### 1. Raw data quality issue
TODO:

##### 2. Create `curated` schema
TODO:

##### 3. ?
TODO:

##### 4. Create views
TODO:

### Deliverable 3: Materialized Views, Clustering, Run Script, Drop Script, Documentation

#### 1. Give two specific use cases where clustering and materialized views may be beneficial to the consumption of the sales data.

Using materialized views could be beneficial when there is a sub-query that is used a lot by many people in many queries, but the sub-query itself is expensive to run. In this case, we can create a materialized view for this particular sub-query. Therefore any query involves this sub-query can start from the materialized view, instead of executing from scratch. 

A use case of using materialized view in this dataset is ...

Reference: [Working with Materialized Views](https://docs.snowflake.com/en/user-guide/views-materialized.html)

Using clustering could be beneficial when ...

A use case of using clustering in this dataset is ...

Reference: [Clustering Keys & Clustered Tables](https://docs.snowflake.com/en/user-guide/tables-clustering-keys.html)

#### 2. Removal script.
See sql file and command in [Removal Script](#3-removal-script).

#### 3. ?
TODO: