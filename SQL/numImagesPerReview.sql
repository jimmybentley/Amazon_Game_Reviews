-- returns number of images per review
select review_id, count(image) as image_count from images group by review_id order by image_count desc;