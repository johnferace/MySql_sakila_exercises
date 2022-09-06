USE sakila;

SHOW TABLES;

SELECT * FROM category;

DESC film;

SELECT customer_id, first_name, last_name
FROM customer
WHERE last_name = 'ZIEGLER';

SELECT language_id,
 'COMMON' AS language_usage,
 language_id * 3.141592 AS lang_pi_value,
 upper(name) AS language_name
FROM language;
 
SELECT user(), 
 version(), 
 database();

SELECT DISTINCT actor_id 
FROM film_actor
ORDER BY actor_id;

SELECT * FROM customer;

SELECT concat(cust.last_name, ', ', cust.first_name) full_name
FROM (SELECT first_name, last_name, email
FROM customer
WHERE first_name = 'JESSIE'
) cust;

CREATE TEMPORARY TABLE actors_j
(actor_id smallint(5),
first_name VARCHAR(45),
last_name VARCHAR(45)
);

SELECT * FROM actors_j;

INSERT INTO actors_j
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'J%';

CREATE VIEW cust_vw AS
SELECT customer_id, first_name, last_name, ACTIVE
FROM customer;

SELECT first_name, last_name 
FROM cust_vw
WHERE ACTIVE = 0;

SELECT * FROM actor;

#TABLA CREADDA
CREATE TABLE new_table #(fer1 INT(30), fer2 VARCHAR(30))
SELECT actor_id fer123, first_name fer234
FROM actor
WHERE  actor_id >'3' AND actor_id < '50';
#>< 
SELECT * FROM new_table
ORDER BY first_name;

DROP TABLE new_table;
#END TABLA
 
 USE sakila;

SELECT customer.first_name ferfer, customer.last_name, time(rental.rental_date) rental_time123
FROM customer
 INNER JOIN rental
 ON customer.customer_id = rental.customer_id
WHERE date(rental.rental_date) = '2005-06-14';	
 
#lo mismo que lo de arriba solo que con alias
SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
 FROM customer c
 INNER JOIN rental r
 ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';

SELECT title
FROM film
WHERE (rating = 'G' AND rental_duration  >=7) 
   OR (rating = 'PG-13' AND rental_duration < 4);
 
USE sakila;
SELECT * FROM customer;

SHOW FIELDS FROM customer;
ALTER TABLE customer MODIFY active VARCHAR(10);
SHOW FIELDS FROM customer;
ALTER TABLE customer MODIFY active TINYINT(1);

SELECT c.first_name, c.last_name, count(*)
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING count(*)  >= 40;

SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY time(r.rental_date) desc;

SELECT c.first_name, c.last_name, time(r.rental_date) rental_time
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 3 desc; # el tres toma la tercera posicion en el la sentencia SELECT en este caso rental_time

SELECT actor_id, first_name, last_name
FROM actor 
ORDER BY last_name, first_name;

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'WILLIAMS' OR last_name = 'DAVIS';
 
SELECT * FROM rental;

SELECT DISTINCT customer_id
FROM rental r
WHERE date(r.rental_date) = '2005-07-05'
ORDER BY customer_id;
 
SELECT c.email, r.return_date
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY 2 DESC;
 
 
 
 
 
 
 
 
 