select * from users order by created_at limit 5;

select *, dayofweek(created_at), count(dayofweek(created_at)) as day
from users group by dayofweek(created_at) order by day desc;

select * from users left join photos on users.id = photos.user_id 
where photos.image_url is null;

-- select *, count(photo_id) as likes from likes join users 
-- on likes.user_id = users.id group by photo_id order by likes desc limit 20;

select username, image_url, photos.id, count(image_url) as likes from likes join photos 
on likes.photo_id = photos.id join users on users.id = photos.user_id 
group by photo_id order by likes desc limit 10;

select (select count(*) from photos) / (select count(*) from users);

select *, count(photo_id) as popular from tags join photo_tags on tags.id = photo_tags.tag_id
group by tag_id order by popular desc limit 10;

select *, count(photo_id) as total from likes join users on likes.user_id = users.id 
group by user_id order by total desc limit 20;

select *, count(photo_id) as total from likes join users on likes.user_id = users.id 
group by user_id having total = (select count(*) from photos) limit 20;