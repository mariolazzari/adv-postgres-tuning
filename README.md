# Advanced SQL for Query Tuning and Performance Optimization

## How to SQL executes queries

### From declarative SQL to a procedural execution plan

- Declarative: specify what you want, not how to get it
- Declarative statements create execution plans

### Scanning tables and indexes

- Cost: number of scanned rows
- Index reduces scanned rows
- Index are ordered

#### Index types

- B-tree: used for equality and range queries
- Hash: used for equality
- Bitmap: used for inclusion
- Specialized: geo-spatial or custom

### Joinng tables

- Nested loop join: compare all rows in both tables
- Hash join: compute hash value of key and join
- Sort merge join: sort both table and join

### Partitioning data

- Sort data in multiple sub-tables, known as partitions
- Improve queries

## Tools for tuning

### Usign PostgreSQL

```sql
select * from staff;
```

### Explain and analyze

```sql
SELECT * from staff

EXPLAIN SELECT * FROM STAFF
EXPLAIN ANALYZE select * from staff
EXPLAIN ANALYZE select last_name from staff
```

### Where clause

```sql
SELECT * FROM staff WHERE salary > 75000

EXPLAIN SELECT * FROM staff where salary > 75000
EXPLAIN SELECT * FROM staff

EXPLAIN ANALYZE SELECT * FROM staff where salary > 75000
```

### Indexes

```sql
CREATE INDEX idx_staff_salary ON staff(salary)

EXPLAIN SELECT * FROM staff
EXPLAIN ANALYZE SELECT * FROM staff where salary > 75000
EXPLAIN ANALYZE SELECT * FROM staff where salary > 150000
```

## Types of index

### Indexing

- Speed up data access
- Enforce constraints
- Ordered
- Smaller than tables
- Reduce table scans
- Duplicates data
- Different organization than table

#### Index type

- B-tree
- Bitmap
- Hash
- Special purpose

### B-tree index

- Balanced tree
- Most common
- High cardinality
- Time based on tree depth

### B-tree index plan

```sql
select count(*) from staff
select * from staff where email = 'bphillips5@time.com'

explain select * from staff where email = 'bphillips5@time.com'
create index idx_staff_email on staff(email);
explain select * from staff where email = 'bphillips5@time.com'

drop index idx_staff_email;
```

### Bitmap index

- Boolean operations
- Small number of possible values in a column
- Time based on bitwise operation to perform

### Bitmap index execution plan

```sql
select distinct job_title from staff order by job_title
select * from staff where job_title = 'operator'
create index idx_staff_job_title on staff(job_title);
explain select * from staff where job_title = 'operator'
```

### Hash index

- Maps data length to fixed string
- Virtually unique
- Input changes produce new hash
- Only for equality
- Smaller than B-tree
- As fast as B-tree

### Hash index execution plan

```sql
create index idx_staff_email on staff using hash (email)
explain select * from staff
where email = 'bphillips5@time.com'
```

### Bloom filter indexes

- Probabilistic and space efficient
- Lossy reppresentation
- False positive
- Arbitrary combinations
- B-tree is faster but bigger

### Specilized indexes

- GIS: generalize search tree
- SP_GIS: space partitioned gis
- GIN: text indexing
- BRIN: block range index

## Tuning joins

### Types of joins

- Inner: all matching rows from both tables
- Left outer: all rows from left table and matching ones from right
- Right outer: all rows from right table and matching ones from left
- Full outer: all rows from both tables

### Nested loops

- Works for all types of join
- 2 loops
- Outer loop: driver (it runs once)
- Inner loop: join (it runs for each row)

### Nested loop plan

```sql
SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id

EXPLAIN SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id

set enable_nestloop=true;
set enable_hashjoin=false;
set enable_mergejoin=false;

SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id

EXPLAIN SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id
```

### Hash joins

- Function that creates data for mapping data
- Can act as an index for fetching that data
- Virtually unique
- It uses the smaller table and it stores its values
- Equality only
- Time based on table size
- Fast lookup

### Hash join plan

```sql
set enable_nestloop=false;
set enable_hashjoin=true;
set enable_mergejoin=false;

EXPLAIN SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id
```

### Merge join

- Sort merge
- First step i sorting both tables
- Sort reduces the number of checks
- Equality only
- Time based on table size
- Large tables join

### Merge join plan

```sql
set enable_nestloop=false;
set enable_hashjoin=false;
set enable_mergejoin=true;

EXPLAIN SELECT
  s.id, s.last_name, s.job_title, cr.country
FROM
   staff s
INNER JOIN
   company_regions cr
ON
   s.region_id = cr.region_id
```

### Sub-queries vs joins

```sql
SELECT s.id, s.last_name, s.department,
 (SELECT 
 company_regions
 FROM
 company_regions cr)
 WHERE
 cr.region_id = s.region_staff s
```

- Same logical outcome
- More than one way to express same thing
- Join more efficient
- Choose more clarity one in code

## Partitioning Data

### Horizontal vs Verical

#### Horizontal partitioning

- Large tables could lead to bad query performance
- Split tables by rows into partitions
- Treat each partition like a table
- Limit scan on subsets
- Local index for each partition
- Efficient add and delete operations
- Data warehouse
- Timeseries
- Naturally driven

#### Vertical patitioning

- Separates columns into multiple tables
- Keep frequently queried columns togheter
- Same primary key
- More rows for data block
- Global indexes
- Reduce I/O
- Data analytics
- Tech data

### Range partition

- Horizontal partitioning
- Partition on non overlapping keys
- Partition by dates
- Numeric range
- Alphabetic range
- Partition key determines which partition
- Min and max value for each partition
- Each partition has its own constraints
- Queries latest data
- Comparative queries
- Report with ranges

### Range partition example

```sql
CREATE TABLE iot_measurement
( location_id int not null,
measure_date timestamp not null,
temp_celcius int,
rel_humidity_pct int)
PARTITION BY RANGE (measure_date);


CREATE TABLE iot_measurement_wk1_2024 PARTITION OF iot_measurement
FOR VALUES FROM ('2024-01-01') TO ('2024-01-08');


CREATE TABLE iot_measurement_wk2_2024 PARTITION OF iot_measurement
FOR VALUES FROM ('2024-01-08') TO ('2024-01-15');


CREATE TABLE iot_measurement_wk3_2024 PARTITION OF iot_measurement
FOR VALUES FROM ('2024-01-15') TO ('2024-01-22');
```

### List partitioning

- Horizontal partitioning
- On non overlapping keys
- On list of values
- Partition key determines which partition
- Partition bounds determines the portion on values
- Each partition has its own constraints

### List partitioning example

```sql
create table products
 (prod_id int not null,
  prod_name text not null,
  prod_descr text not null,
  prod_category text)
partition by list (prod_category);

create table product_clothing partition of products
 for values in (‘casual_clothing’, ‘business_attire’, ‘formal_clothing);

create table product_electronics partition of products
 for values in (‘mobile_phones’, ‘tablets’, ‘laptop_computers’);

create table product_kitches partition of products
 for values in (‘food_processor, ‘cutlery’, ‘blenders’);
```

### Partition by hash
