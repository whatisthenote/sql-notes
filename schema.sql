create table users (
  email varchar(255) primary key,
  created_at timestamp default now()
);

select date_format(min(created_at), '%M %D %Y') as earliest_date from users;
select *, date_format(created_at, '%M %D %Y') from users order by created_at limit 10;
select * from users where created_at = (select min(created_at) from users);
select date_format(created_at, '%M') as month, count(*) as count from users group by month order by count desc;
select count(*) from users where email like '%@yahoo.com%';
select case
when email like '%@yahoo.com%' then 'yahoo'
when email like '%@gmail.com%' then 'gmail'
when email like '%@hotmail.com%' then 'hotmail'
else 'other'
end as provider, count(*) as total_users  from users group by provider order by total_users desc;
