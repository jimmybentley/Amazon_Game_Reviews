-- time series of monthly number of posts
select extract(year from reviewTime) as year, extract(month from reviewTime) as month, count(review_id) as monthly_posts
from reviews
group by extract(year from reviewTime), extract(month from reviewTime)
order by year desc, month desc;