# CSCI 5751 Project 2

Group: yeSQL

Slack Channel: yeSQL

Team members: 
- John Carruth
- Yuchuan Huang
- Sam Walczak
- Hexuan Zhang.

Instruction: [Project 2 – Snowflake POC](https://drive.google.com/file/d/18eDxHup4DcRabKuPZ-gJcgGCNsvFwjtj/view?usp=sharing)

## Set Up
1. Clone Github repository.
```
git clone https://github.com/HunterZ1998/BigData2022P2.git
```

2. Change directory to Github repo. (**Please run all following commands in the directory `<path>/BigData2022P2`**)
```
cd BigData2022P2
```

## Test: run all files in order
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

## Removal Script
```
snowsql -a gu89366.us-east-2.aws -u tester --private-key-path rsa_key.p8 -f remove_all.sql
```



## Deliverable 2: Data load, Database, Tables, Views
### Step 1: Get and Load Raw Data

### Step 2: Prepare Data for Business Consumption.
#### 1. Raw data quality issue

#### 2. Create `curated` schema

#### 3. ?

#### 4. Create views. 

## Deliverable 3: Materialized Views, Clustering, Run Script, Drop Script, Documentation

#### 1. Give two specific use cases where clustering and materialized views may be beneficial to the consumption of the sales data.



#### 2. Removal script.


#### 3. ?

##### 1. All sql files to run in order
