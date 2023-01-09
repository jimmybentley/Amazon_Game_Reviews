-- users who post the most pictures
select reviews.reviewer_id, count(images.image) / count(distinct reviews.review_id) as images_per_review, count(images.image) as total_images
from images 
right outer join reviews
	on reviews.review_id = images.review_id
group by reviews.reviewer_id
order by images_per_review desc, total_images desc;