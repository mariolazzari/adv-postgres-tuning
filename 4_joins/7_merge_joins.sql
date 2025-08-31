set
    enable_nestloop = false;

set
    enable_hashjoin = false;

set
    enable_mergejoin = true;

EXPLAIN
SELECT
    s.id,
    s.last_name,
    s.job_title,
    cr.country
FROM
    staff s
    INNER JOIN company_regions cr ON s.region_id = cr.region_id