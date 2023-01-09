PRAGMA foreign_keys=ON;

create table Reviewers(reviewer_id varchar(20) primary key,
	reviewerName text
);
COPY reviewers FROM 'C:/Users/Jimmy/Desktop/Amazon_Game_Reviews/reviewers.csv' DELIMITER ',';


create table Styles(style_id int primary key,
	style text
);
COPY styles from 'C:/Users/Jimmy/Desktop/Amazon_Game_Reviews/styles.csv' DELIMITER ',';

create table Reviews(review_id int primary key,
	overall real, -- float rating 1-5
	verified boolean, -- review is verified
	reviewTime date,
	reviewer_id varchar(20) references Reviewers(reviewer_id),
	asin varchar(10),
	reviewText text,
	vote int
);
COPY reviews FROM 'C:/Users/Jimmy/Desktop/Amazon_Game_Reviews/reviews.csv' DELIMITER ',';


create table Images(image_id int primary key,
	review_id int,
	image_url text,
	FOREIGN KEY(review_id) references reviews(review_id)
);
COPY images FROM 'C:/Users/Jimmy/Desktop/Amazon_Game_Reviews/images.csv' DELIMITER ',';


create table reviewStyle(review_id int references Reviews(review_id),
	style_id int references Styles(style_id),
	primary key(review_id, style_id)
);
COPY reviewStyle FROM 'C:/Users/Jimmy/Desktop/Amazon_Game_Reviews/reviewStyle.csv' DELIMITER ',';
