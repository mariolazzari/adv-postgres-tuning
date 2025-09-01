create materialized view mv_staff as
select
    s.last_name,
    s.department,
    s.job_title,
    cr.company_regions
from
    staff s
    inner join company_regioins cr on s.region_id = cr.region_id