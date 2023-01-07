-- average rating over time
select extract(year from reviewTime) as year, extract(month from reviewTime) as month, avg(overall) as round(monthly_posts, 2)
from reviews
group by extract(year from reviewTime), extract(month from reviewTime)
order by year desc, month desc;