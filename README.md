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
