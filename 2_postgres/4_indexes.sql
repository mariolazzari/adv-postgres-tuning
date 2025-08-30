CREATE INDEX idx_staff_salary ON staff (salary) EXPLAIN
SELECT
    *
FROM
    staff EXPLAIN ANALYZE
SELECT
    *
FROM
    staff
where
    salary > 75000 EXPLAIN ANALYZE
SELECT
    *
FROM
    staff
where
    salary > 150000