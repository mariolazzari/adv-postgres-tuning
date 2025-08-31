SELECT
    s.id,
    s.last_name,
    s.job_title,
    cr.country
FROM
    staff s
    INNER JOIN company_regions cr ON s.region_id = cr.region_id EXPLAIN
SELECT
    s.id,
    s.last_name,
    s.job_title,
    cr.country
FROM
    staff s
    INNER JOIN company_regions cr ON s.region_id = cr.region_id
set
    enable_nestloop = true;

set
    enable_hashjoin = false;

set
    enable_mergejoin = false;

SELECT
    s.id,
    s.last_name,
    s.job_title,
    cr.country
FROM
    staff s
    INNER JOIN company_regions cr ON s.region_id = cr.region_id EXPLAIN
SELECT
    s.id,
    s.last_name,
    s.job_title,
    cr.country
FROM
    staff s
    INNER JOIN company_regions cr ON s.region_id = cr.region_id