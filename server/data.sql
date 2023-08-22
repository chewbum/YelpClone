CREATE TABLE restaurants (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	location VARCHAR(50) NOT NULL,
	price_range INT NOT NULL check(price_range >= 1 and price_range <= 5)
);

insert into restaurants (name, location, price_range) values ('taco bell', 'san fran', 3);
insert into restaurants (name, location, price_range) values ('wendys', 'new york', 4);


UPDATE restaurants
SET id = 3 
WHERE id = (SELECT max(id) FROM restaurants);


SELECT setval('restaurants_id_seq', (SELECT max(id) FROM restaurants));

CREATE TABLE reviews (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	restaurant_id BIGINT NOT NULL  REFERENCES restaurants(id),
	name VARCHAR(50) NOT NULL,
	review TEXT NOT NULL,
	rating INT NOT NULL check(rating >=1 and rating <=5)
);

INSERT INTO reviews (restaurant_id, name, review, rating) values (1,'carl', 'restaurant was awesome', 5);
INSERT INTO reviews (restaurant_id, name, review, rating) values (1,'zixuan', 'restaurant was grape', 5);
INSERT INTO reviews (restaurant_id, name, review, rating) values (1,'bandit', 'restaurant was bombz', 5);
INSERT INTO reviews (restaurant_id, name, review, rating) values (2,'yiqing', 'restaurant was bombz', 5);

SELECT restaurant_id, count(restaurant_id) from reviews group by restaurant_id; 

SELECT * from restaurants left join (SELECT restaurant_id, count(*), TRUNC(AVG(rating),1) as average_rating from reviews group by restaurant_id) reviews on restaurants.id =reviews.restaurant_id;
