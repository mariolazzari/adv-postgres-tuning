SELECT
    s.id,
    s.last_name,
    s.department,
    (
        SELECT
            company_regions
        FROM
            company_regions cr
    )
WHERE
    cr.region_id = s.region_staff s