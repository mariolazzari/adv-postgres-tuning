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

```sql

```
