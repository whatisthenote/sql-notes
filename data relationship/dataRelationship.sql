CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

       
-- No user with id: 98

INSERT INTO orders (order_date, amount, customer_id) VALUES ('2016/06/06', 33.67, 98);

-- Finding Orders Placed By George: 2 Step Process

SELECT id FROM customers WHERE last_name='George';

SELECT * FROM orders WHERE customer_id = 1;

-- Finding Orders Placed By George: Using a subquery

SELECT * FROM orders WHERE customer_id = 
(SELECT id FROM customers WHERE last_name='George');

-- Cross Join Craziness

SELECT * FROM customers, orders; 

-- IMPLICIT INNER JOIN

SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;

-- EXPLICIT INNER JOINS

SELECT * FROM customers JOIN orders ON customers.id = orders.customer_id;
    
SELECT * FROM orders JOIN customers ON customers.id = orders.customer_id;

-- ARBITRARY JOIN - meaningless, but still possible 

SELECT * FROM customers JOIN orders ON customers.id = orders.id;

-- Getting Fancier (Inner Joins Still)

SELECT first_name, last_name, order_date, amount FROM customers 
JOIN orders ON customers.id = orders.customer_id ORDER BY order_date;

SELECT first_name, last_name, SUM(amount) AS total_spent FROM customers
JOIN orders ON customers.id = orders.customer_id GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- LEFT JOINS

SELECT * FROM customers LEFT JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id; 

SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total_spent FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id GROUP BY customers.id
ORDER BY total_spent;

-- OUR FIRST RIGHT JOIN (seems the same as a left join?)

SELECT * FROM customers RIGHT JOIN orders ON customers.id = orders.customer_id;

-- ALTERING OUR SCHEMA to allow for a better example (optional)

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT
);

-- INSERTING NEW DATA (no longer bound by foreign key constraint)

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

INSERT INTO orders (order_date, amount, customer_id) VALUES
('2017/11/05', 23.45, 45),
(CURDATE(), 777.77, 109);

--A MORE COMPLEX RIGHT JOIN

SELECT 
    IFNULL(first_name,'MISSING') AS first, 
    IFNULL(last_name,'USER') as last, 
    order_date, 
    amount, 
    SUM(amount)
FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY first_name, last_name;

-- WORKING WITH ON DELETE CASCADE

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

SELECT * FROM customers LEFT JOIN orders ON customers.id = orders.customer_id;

SELECT * FROM orders RIGHT JOIN customers ON customers.id = orders.customer_id;    

SELECT * FROM orders LEFT JOIN customers ON customers.id = orders.customer_id;    

SELECT * FROM customers RIGHT JOIN orders ON customers.id = orders.customer_id;

-- The Schema

CREATE TABLE students (id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(100));

CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY (student_id) 
    REFERENCES students(id)
    ON DELETE CASCADE
);

-- The Starter Data

INSERT INTO students (first_name) VALUES 
('Caleb'), 
('Samantha'), 
('Raj'), 
('Carlos'), 
('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

select first_name, title, grade from students 
join papers on students.id = papers.student_id order by first_name desc;

select first_name, title, grade from students 
left join papers on students.id = papers.student_id;

select first_name, ifnull(title, 'MISSING'), ifnull(grade, 0) from students
left join papers on students.id = papers.student_id;

select first_name, ifnull(avg(grade), 0) as average from students left join papers
on students.id = papers.student_id group by first_name order by avarage desc;

select first_name, ifnull(avg(grade), 0) as average, case when avg(grade) >=  75 
then 'PASSING' else 'FAILING' end as passing_status from students left join papers on 
students.id = papers.student_id group by first_name order by average desc;





-- CREATING THE REVIEWERS TABLE

CREATE TABLE reviewers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- CREATING THE SERIES 

CREATE TABLE series(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

-- CREATING THE REVIEWS 

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

-- INSERTING A BUNCH OF DATA

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');


INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    

INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),(8,4,8.5),(8,2,7.8),(8,6,8.8),
    (8,5,9.3),(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),
    (9,5,4.5),(10,5,9.9),(13,3,8.0),(13,4,7.2),(14,2,8.5),
    (14,3,8.9),(14,4,8.9);

    -- TV Joins Challenge 1 SOLUTION


SELECT title, rating FROM series JOIN reviews ON series.id = reviews.series_id;

SELECT title, AVG(rating) as avg_rating FROM series JOIN reviews
ON series.id = reviews.series_id GROUP BY series.id ORDER BY avg_rating;

SELECT first_name, last_name, rating FROM reviewers
INNER JOIN reviews ON reviewers.id = reviews.reviewer_id;

SELECT first_name, last_name, rating FROM reviews
INNER JOIN reviewers ON reviewers.id = reviews.reviewer_id;

SELECT title AS unreviewed_series FROM series LEFT JOIN reviews
ON series.id = reviews.series_id WHERE rating IS NULL;

SELECT genre, Round(Avg(rating), 2) AS avg_rating FROM series INNER JOIN reviews 
ON series.id = reviews.series_id GROUP BY genre; 

select first_name, last_name, count(rating) as count, ifnull(min(rating), 0) as min, 
ifnull(max(rating), 0) as max, round(ifnull(avg(rating), 0), 2) as avg, 
if(count(rating) > 0, 'ACTIVE', 'INACTIVE') as status from reviewers 
left join reviews on reviewers.id = reviews.reviewer_id group by reviewers.id;

select first_name, last_name, count(rating) as count, ifnull(min(rating), 0) as min, 
ifnull(max(rating), 0) as max, round(ifnull(avg(rating), 0), 2) as avg, 
case when count(rating) >= 10  then 'power user' when count(rating) > 0 then 'active'
else 'inactive' end as status from reviewers 
left join reviews on reviewers.id = reviews.reviewer_id group by reviewers.id;

select title, rating, concat(first_name, ' ', last_name) as reviewers from series
join reviews on reviewer_id = series.id join reviewers 
on reviewers.id = reviews.reviewer_id order by title, rating desc;