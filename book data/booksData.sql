CREATE DATABASE book_shop;

USE book_shop;

CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

select concat(author_fname, ' ', author_lname) as 'fullname' from books;

SELECT concat_ws('-', title, author_fname, author_lname) from books;

select substring(title, 1,10) as short_title from books;

select concat(substring(title, 1, 10), '...') as short_title from books;

select replace('Hello World', 'Hell', '#&%^');

select replace(title, 'e', '3') from books;

select substring(replace(title, 'e', '3'), 1, 10) from books;

select concat(author_fname, reverse(author_lname)) from books;

select author_lname, char_length(author_lname) as length from books;

select concat(author_lname, ' is ', char_length(author_lname), ' characters long') from books; 

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES 
('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
('fake_book', 'Freida', 'Harris', 2001, 287, 428),
('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

SELECT author_lname FROM books;

SELECT DISTINCT author_lname FROM books;

SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;

SELECT DISTINCT author_fname, author_lname FROM books

SELECT author_lname FROM books ORDER BY author_lname;

SELECT author_lname FROM books ORDER BY author_lname DESC;

SELECT released_year FROM books;

SELECT released_year FROM books ORDER BY released_year;

SELECT released_year FROM books ORDER BY released_year DESC;

SELECT released_year FROM books ORDER BY released_year ASC;

SELECT title, released_year, pages FROM books ORDER BY released_year;

SELECT title, pages FROM books ORDER BY released_year;

SELECT title, author_fname, author_lname 
FROM books ORDER BY 2;

SELECT author_fname, author_lname FROM books 
ORDER BY author_lname, author_fname;

SELECT title FROM books LIMIT 3;

SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 0,5;

SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 0,3;

SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 1,3;

SELECT title, released_year FROM books 
ORDER BY released_year DESC LIMIT 10,1;

SELECT * FROM tbl LIMIT 95,18446744073709551615;

SELECT title FROM books LIMIT 5;

SELECT title FROM books LIMIT 5, 123219476457;

SELECT title FROM books LIMIT 5, 50;

SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';

SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';

SELECT title FROM books WHERE  title LIKE 'the';

SELECT title FROM books WHERE  title LIKE '%the';

SELECT title FROM books WHERE title LIKE '%the%';

SELECT title, stock_quantity FROM books;

SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';

SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '__';

(235)234-0987 LIKE '(___)___-____'

SELECT title FROM books;

SELECT title FROM books WHERE title LIKE '%\%%'

SELECT title FROM books WHERE title LIKE '%\_%'

SELECT COUNT(*) FROM books;

SELECT COUNT(author_fname) FROM books;

SELECT COUNT(DISTINCT author_fname) FROM books;

SELECT COUNT(DISTINCT author_lname) FROM books;

SELECT COUNT(DISTINCT author_lname, author_fname) FROM books;

SELECT title FROM books WHERE title LIKE '%the%';

SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

SELECT title, author_lname FROM books;

SELECT title, author_lname FROM books GROUP BY author_lname;

SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;

SELECT title, author_fname, author_lname FROM books GROUP BY author_lname;

SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname;

SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname,
author_fname;

SELECT released_year, COUNT(*) FROM books GROUP BY released_year;

SELECT CONCAT(released_year, ' ', COUNT(*), ' book(s) released') AS year
FROM books GROUP BY released_year;

SELECT MIN(released_year) FROM books;

SELECT MIN(pages) FROM books;

SELECT MAX(pages) FROM books;

SELECT MAX(pages), title FROM books;

SELECT title, pages FROM books WHERE pages = (SELECT Max(pages) FROM books); 

SELECT title, pages FROM books WHERE pages = (SELECT Min(pages) FROM books); 

SELECT title, pages FROM books ORDER BY pages ASC LIMIT 1;

SELECT * FROM books ORDER BY pages DESC LIMIT 1;

SELECT author_fname, author_lname, Min(released_year) FROM books 
GROUP BY author_lname, author_fname;

SELECT author_fname, author_lname, Max(pages) FROM books
GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) AS author, 
MAX(pages) AS 'longest book' FROM books GROUP BY author_lname, author_fname;
				 
SELECT SUM(pages) FROM books;

SELECT author_fname, author_lname, Sum(pages) FROM books 
GROUP BY author_lname, author_fname;

SELECT author_fname, author_lname, Sum(released_year) FROM books
GROUP BY author_lname, author_fname;

SELECT AVG(released_year) FROM books;

SELECT AVG(pages) FROM books;

SELECT AVG(stock_quantity) FROM books GROUP BY released_year;

SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;

SELECT author_fname, author_lname, AVG(pages) FROM books
GROUP BY author_lname, author_fname;

SELECT title FROM books WHERE title LIKE '%W%';

SELECT title FROM books WHERE title NOT LIKE 'W%';

SELECT title, released_year FROM books 
WHERE released_year > 2000 ORDER BY released_year;

SELECT title, released_year FROM books 
WHERE released_year >= 2000 ORDER BY released_year;

SELECT title, stock_quantity FROM books WHERE stock_quantity >= 100;

SELECT 99 > 1;

SELECT 99 > 567;

100 > 5
-- true

-15 > 15
-- false

9 > -10
-- true

1 > 1
-- false

'a' > 'b'
-- false

'A' > 'a'
-- false

'A' >=  'a'
-- true

SELECT title FROM books WHERE released_year = 2017;

SELECT title FROM books WHERE released_year != 2017;

SELECT title, released_year FROM books;

SELECT title, author_lname, released_year FROM books WHERE author_lname='Eggers' 
AND released_year > 2010;

SELECT 1 < 5 && 7 = 9;
-- false

SELECT -10 > -20 && 0 <= 0;
-- true

SELECT -40 <= 0 AND 10 > 40;
--false

SELECT 54 <= 54 && 'a' = 'A';
-- true

SELECT * FROM books WHERE author_lname='Eggers' 
AND released_year > 2010 AND title LIKE '%novel%';

SELECT title, author_lname, released_year FROM books 
WHERE author_lname='Eggers' || released_year > 2010;


SELECT 40 <= 100 || -2 > 0;
-- true

SELECT 10 > 5 || 5 = 5;
-- true

SELECT 'a' = 5 || 3000 > 2000;
-- true

SELECT title, author_lname, released_year, stock_quantity FROM books 
WHERE author_lname = 'Eggers' || released_year > 2010 OR stock_quantity > 100;

SELECT title, released_year FROM books WHERE released_year BETWEEN 2004 AND 2015;

SELECT title, released_year FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;

SELECT CAST('2017-05-02' AS DATETIME);

SELECT name, birthdt FROM people WHERE birthdt BETWEEN '1980-01-01' AND '2000-01-01';

SELECT name, birthdt FROM people WHERE birthdt BETWEEN CAST('1980-01-01' AS DATETIME)
AND CAST('2000-01-01' AS DATETIME);

SELECT title, author_lname FROM books WHERE author_lname='Carver' OR
author_lname='Lahiri' OR author_lname='Smith';

SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT title, released_year FROM books WHERE released_year IN (2017, 1985);

SELECT title, released_year FROM books
WHERE released_year != 2000 AND
      released_year != 2002 AND
      released_year != 2004 AND
      released_year != 2006 AND
      released_year != 2008 AND
      released_year != 2010 AND
      released_year != 2012 AND
      released_year != 2014 AND
      released_year != 2016;

SELECT title, released_year FROM books WHERE released_year 
NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);

SELECT title, released_year FROM books 
WHERE released_year >= 2000 AND released_year % 2 != 0;

SELECT title, released_year,
       CASE 
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM books;

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

SELECT title,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        WHEN stock_quantity BETWEEN 101 AND 150 THEN '***'
        ELSE '****'
    END AS STOCK
FROM books;

SELECT title, stock_quantity,
    CASE 
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books; 



0

1

1

select * from books where released_year < 1980;

select * from books where author_lname = 'eggers' || author_lname = 'chabon';

select * from books where author_lname in ('eggers', 'chabon');

select * from books where author_lname = 'lahiri' && released_year > 2000;

select * from books where pages between 100 and 200;

select * from books where author_lname like 'C%' || author_lname like 'S%';

select * from books where author_lname like in ('C%');

select title,
case when title like '%stories%' then 'short stories'
when title = 'Just Kids' ||  title like '%a heartbreaking work%' then 'memoir'
else 'novel' end as 'type' from books;

select author_fname, author_lname, 
case when count(author_lname) = 1 then concat(count(author_lname), ' ', 'book')
else concat(count(author_lname), ' ', 'books') end as 'count'
from books group by author_lname, author_fname; 