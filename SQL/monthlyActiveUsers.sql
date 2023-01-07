-- time series of monthly active users
select extract(year from reviewTime) as year, extract(month from reviewTime) as month, count(distinct reviewer_id) as monthly_active_users
from reviews
group by extract(year from reviewTime), extract(month from reviewTime)
order by year desc, month desc;