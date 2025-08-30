select distinct
    job_title
from
    staff
order by
    job_title
select
    *
from
    staff
where
    job_title = 'operator' create index idx_staff_job_title on staff (job_title);

explain
select
    *
from
    staff
where
    job_title = 'operator'