select
    count(*)
from
    staff
select
    *
from
    staff
where
    email = 'bphillips5@time.com' explain
select
    *
from
    staff
where
    email = 'bphillips5@time.com' create index idx_staff_email on staff (email);

explain
select
    *
from
    staff
where
    email = 'bphillips5@time.com'
drop index idx_staff_email;