PRAGMA foreign_keys=ON;

create table Reviewers(reviewer_id varchar(20) primary key,
	reviewerName text
);
COPY reviewers FROM 'C:/Users/jimmy/Desktop/GOOD_PROJECT/reviewers.csv' DELIMITER ',';


create table Styles(style_id int primary key,
	style text
);
COPY styles from 'C:/Users/jimmy/Desktop/GOOD_PROJECT/styles.csv' DELIMITER ',';

create table Reviews(review_id int primary key,
	overall real, -- float rating 1-5
	verified boolean, -- review is verified
	reviewTime date,
	reviewer_id varchar(20) references Reviewers(reviewer_id),
	asin varchar(10),
	reviewText text,
	vote int
);
COPY reviews FROM 'C:/Users/jimmy/Desktop/GOOD_PROJECT/reviews.csv' DELIMITER ',';


create table Images(image_id int primary key,
	review_id int,
	image text,
	FOREIGN KEY(review_id) references reviews(review_id)
);
COPY images FROM 'C:/Users/jimmy/Desktop/GOOD_PROJECT/images.csv' DELIMITER ',';


create table reviewStyle(review_id int references Reviews(review_id),
	style_id int references Styles(style_id),
	primary key(review_id, style_id)
);
COPY reviewStyle FROM 'C:/Users/jimmy/Desktop/GOOD_PROJECT/reviewStyle.csv' DELIMITER ',';
