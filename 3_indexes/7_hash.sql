create index idx_staff_email on staff using hash (email) explain
select
    *
from
    staff
where
    email = 'bphillips5@time.com'