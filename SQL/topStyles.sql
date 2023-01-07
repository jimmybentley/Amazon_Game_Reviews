-- returns top 50 most popular style categories by counts
select b.style, count(*) as style_count
from reviewStyle a, styles b
where a.style_id = b.style_id
group by a.style_id, b.style
order by style_count desc
limit 50;