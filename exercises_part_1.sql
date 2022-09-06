/*ASI SE HACN COMENTARIOS*/
#TAMBIEN ASI 


CREATE DATABASE prueba_0
(columna_1 INT NOT NULL,
columna_2 INT NOT NULL,
columna_3 INT NOT NULL,
PRIMARY KEY(columna_1)
);

SHOW CHARACTER SET;
SHOW DATABASES;

SELECT now();
DESC actor ;
USE base_de_prueba_1;

CREATE SCHEMA `base_de_prueba_1` DEFAULT CHARACTER SET utf8mb4 ;
DROP DATABASE `Prubea_fer_1`;

CREATE TABLE person
(person_id SMALLINT UNSIGNED,
fname VARCHAR(20),
lname VARCHAR(20),
eye_color ENUM('BR', 'BL', 'GR'),
birth_date DATE,
street VARCHAR(30),
city VARCHAR(20),
state VARCHAR(20),
country VARCHAR(20),
postal_code VARCHAR(20),
CONSTRAINT pk_person PRIMARY KEY (person_id)
);

CREATE TABLE favorite_food
(person_id SMALLINT UNSIGNED,
food VARCHAR(20),
CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
REFERENCES person (person_id)
);

SELECT * FROM favorite_food;

DESC person;
DESC favorite_food;

DROP TABLE favorite_food;

ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;

USE base_de_prueba_1;

INSERT INTO person (person_id, fname, lname, eye_color, birth_date)
VALUES (NULL, 'Williamsss', 'Turnersss', 'BR', '1971-05-27');

SELECT person_id, fname, lname, eye_color, birth_date 
FROM person 
WHERE lname = 'Turner';

SELECT * FROM favorite_food;
SELECT * FROM person;

SELECT food FROM favorite_food
WHERE person_id = 3
ORDER BY food;

INSERT INTO favorite_food (person_id, food) 
VALUES (3, 'tacos'), (3, 'Sushi');

INSERT INTO person (person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
VALUES (NULL, 'Susan','Smith', 'BL', '1975-11-02','23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

UPDATE person
SET street = '1225 Tremont St. 1',
    city = 'Boston 1',
    state = 'MA1',
    country = 'USA1',
    postal_code = '021381'
WHERE person_id < 3;

SELECT * FROM person;

DELETE FROM person 
WHERE person_id = 7;

UPDATE person
SET birth_date = str_to_date('DEC-21-1980' , '%b-%d-%Y')
WHERE person_id = 4;

USE sakila;

SELECT c.email
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';

SELECT * FROM rental;
SELECT * FROM customer;

DELETE FROM rental
WHERE year(rental_date) = 2004;

SELECT c.email
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) <> '2005-06-14'
GROUP BY email;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM rental 
WHERE rental_date < '2005-05-25';

SELECT customer_id, rental_date
FROM rental
WHERE rental_date <= '2005-06-16' AND rental_date >= '2005-06-14';

SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN  '2005-06-14' AND '2005-06-16';

SELECT customer_id, payment_date, amount
FROM payment
WHERE amount BETWEEN 10.0 AND 11.99;

SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FR';

SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FRB';

SELECT * FROM film;

SELECT title, rating
FROM film
WHERE rating = 'G' OR rating = 'PG';
#SON IGUALES
SELECT title, rating
FROM film
WHERE rating IN ('G','PG');

SELECT * FROM film;

SELECT rating 
FROM film 
WHERE title LIKE '%PET%';

SELECT title, rating
FROM film
WHERE rating IN (SELECT rating FROM film WHERE title LIKE '%PET%' GROUP BY rating);

SELECT title, rating
FROM film
WHERE rating NOT IN ('PG-13','R', 'NC-17');

SELECT last_name, first_name
FROM customer
WHERE left(last_name, 1) = 'Q';
#LA DE ARRIBA ES LA BUENA
SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'Q%';

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE '_A_T%S';

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'Q%' OR last_name LIKE 'Y%';

SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[QY]';

USE sakila;

SELECT rental_id
FROM rental
WHERE return_date IS NULL;

SELECT * FROM rental
WHERE rental_id IN (SELECT rental_id FROM rental WHERE return_date IS NULL);

SELECT rental_id, customer_id
FROM rental
WHERE return_date = NULL;

SELECT *
FROM rental
WHERE return_date IS NULL;

SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date BETWEEN '2005-05-01' AND '2006-09-01';

SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

SELECT payment_id, customer_id, amount, payment_date 
FROM payment
WHERE payment_id BETWEEN 101 AND 120;

SELECT payment_id, customer_id, amount, payment_date 
FROM payment
WHERE customer_id != 5 AND (amount > 8 OR date(payment_date) = '2005-08-23');

SELECT *
FROM payment
WHERE amount IN (1.98, 7.98, 9.98);

SELECT * FROM customer;

SELECT first_name, last_name
FROM customer
WHERE last_name LIKE ('_A%W%');

DESC customer;
DESC address;

SELECT c.first_name, c.last_name, a.address
FROM customer c JOIN address a; #crosss join it is rarely used

SELECT c.first_name, c.last_name, a.address
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id;

SELECT c.first_name, c.last_name, a.address
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id;

SELECT c.first_name, c.last_name, a.address
FROM customer c INNER JOIN address a
USING (address_id); #It can be used the subclause USING only if the names on the columns are identical

USE sakila;

SELECT c.first_name, c.last_name, a.address
FROM customer c, address a
WHERE  c.address_id = a.address_id;

SELECT c.first_name, c.last_name, a.address
FROM customer c, address a
WHERE c.address_id = a.address_id AND a.postal_code = 52137;

SELECT c.first_name, c.last_name, a.address
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id
WHERE a.postal_code = 52137;

DESC city;
DESC address;

SELECT c.first_name, c.last_name, ct.city
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id 
INNER JOIN city ct
ON a.city_id = ct.city_id;

SELECT STRAIGHT_JOIN first_name, c.last_name, ct.city
FROM city ct 
  INNER JOIN address a
  ON a.city_id = ct.city_id
  INNER JOIN customer c
  ON c.address_id = a.address_id;

SELECT c.first_name, c.last_name, addr.address, addr.city
FROM customer c
INNER JOIN
(SELECT a.address_id, a.address, ct.city
FROM address a
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California'
) addr
ON c.address_id = addr.address_id;

SELECT c.first_name, c.last_name, addr.address, addr.city
FROM customer c
INNER JOIN
(SELECT a.address_id, a.address, ct.city
FROM address a
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California'
) addr
ON c.address_id = addr.address_id;

SELECT f.title
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor a
ON fa.actor_id = a.actor_id
WHERE  ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN') OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH'));

SELECT f.title
FROM film f
INNER JOIN film_actor fa1
ON f.film_id = fa1.film_id
INNER JOIN actor a1
ON fa1.actor_id = a1.actor_id
INNER JOIN film_actor fa2
ON f.film_id = fa2.film_id
INNER JOIN actor a2
ON fa2.actor_id = a2.actor_id
WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

USE sakila;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM actor;

SELECT f.title
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor a
ON a.actor_id = fa.actor_id
WHERE a.first_name = 'JOHN';

SELECT * FROM address;
SELECT a1.address addr1, a2.address addr2, a1.city_id
FROM address a1
INNER JOIN address a2
WHERE a1.city_id = a2.city_id AND a1.address_id <> a2.address_id;

SELECT * FROM address;
SELECT a1.address addr1, a2.address addr2, a1.city_id
FROM address a1
INNER JOIN address a2
ON a1.city_id = a2.city_id
WHERE a1.address_id <> a2.address_id;

SELECT * FROM city;

USE sakila;
DESC city;
DESC customer;

SELECT 1 num, 'abc' str
UNION
SELECT 9 num, 'xyz' str;

SELECT 'CUST' typ, c.first_name, c.last_name
FROM customer c
UNION ALL #UNION 
SELECT 'ACTR' typ, a.first_name, a.last_name
FROM actor a;

#INTERSECT NO LO SOPORTA
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
#INTERSECT
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%';

#EXCEPT TAMPOCO LO SOPORTA
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
#EXCEPT
SELECT c.first_name, c.last_name
FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

#NO SOPORTA () EN UNIONES COMPUESTAS 
SELECT a.first_name, a.last_name
FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
UNION
SELECT a.first_name, a.last_name
 FROM actor a
 WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
 UNION ALL
 SELECT c.first_name, c.last_name
 FROM customer c
 WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT c.first_name namess, c.last_name last_
FROM customer c
WHERE c.last_name LIKE 'L%'
UNION 
SELECT a.first_name namess, a.last_name last_
FROM actor a
WHERE a.last_name LIKE 'L%'
ORDER BY last_;

USE sakila;

CREATE TABLE IF NOT EXISTS fer_1(
fer_id SMALLINT UNSIGNED,
char_column CHAR(30),
varchar_column VARCHAR(30),
text_column TEXT,
PRIMARY KEY(fer_id)
);

DROP TABLE fer_1;

INSERT INTO fer_1 (fer_id, char_column, varchar_column, text_column)
VALUES(
5,
'This is char data21',
'This is varchar data21',
'This is text data21'
);

SELECT * FROM fer_1;

UPDATE fer_1
SET varchar_column = 'ESTA ES SOLO UNA PRUBEAe3fasdasdasdfafsasfawrvafawfafawfvwfawfv DEL TAMAÑO DEL TIPO DE LETRA QUE SE NECESITA'
WHERE fer_id = 2;

SELECT @@session.sql_mode; #VE SI SE TRUNCA UN CONJUNO DE CARACTERES O NO 
SET sql_mode='ansi'; #VUELVE POR DEFECTO QUE SE TRUNQUE YA QUE DABA ERROR AL EXEDERCE DE CARACTERES

SELECT varchar_column 
FROM fer_1
WHERE fer_id = 2;

UPDATE fer_1
SET text_column = 'this string doesn''t work' #'this string doesn\'t work'
WHERE fer_id = 4;

SELECT quote(text_column) #Muy buena funcion
FROM fer_1
WHERE fer_id = 5;

SELECT 'abcdefg', CHAR(97,98,99,100,101,102,103);
SELECT CHAR(128,129,130,131,132,133,134,135,136,137);

SELECT 'danke sch' + CHAR(148) + 'n';

SELECT ASCII('ö');
SELECT CHAR(195);

DELETE FROM fer_1
WHERE fer_id IN (1, 2, 3, 4 ,5);

SELECT * FROM fer_1;

INSERT INTO fer_1 (fer_id,  char_column, varchar_column, text_column)
VALUES(
1, 'This string is 28 characters', 'This string is 28 characters', 'This string is 28 characters'
);

SELECT length(char_column) char_length, 
       length(varchar_column) varchar_length, 
       length(text_column) text_length
FROM fer_1
WHERE fer_id = 1;

SELECT POSITION('characters' IN varchar_column)
FROM fer_1
WHERE fer_id = 1;

SELECT LOCATE('is', varchar_column, 5)
FROM fer_1
WHERE fer_id = 1;

SELECT * FROM fer_1;

DELETE FROM fer_1
WHERE fer_id = 1;

INSERT INTO fer_1 (fer_id, varchar_column)
VALUES(1, 'abcd'),
      (2, 'xyz'),
      (3, 'QRSTUV'),
      (4, 'qrstuv'),
      (5, '12345');

SELECT varchar_column
FROM fer_1
ORDER BY varchar_column;

SELECT STRCMP('12345','12345') 12345_12345,
       STRCMP('abcd','xyz') abcd_xyz,
       STRCMP('abcd','QRSTUV') abcd_QRSTUV,
       STRCMP('qrstuv','QRSTUV') qrstuv_QRSTUV,
       STRCMP('12345','xyz') 12345_xyz,
       STRCMP('xyz','qrstuv') xyz_qrstuv;

SELECT name, name LIKE '%y' ends_in_y #IMPORTANTE 
FROM category;

SELECT * FROM category;

SELECT name, name REGEXP 'y$' ends_in_y
FROM category;

USE sakila;
SELECT * FROM fer_1;

DELETE FROM fer_1
WHERE fer_id IN (1, 2, 3, 4, 5);

INSERT INTO fer_1 (fer_id, text_column)
VALUES (1, 'This string was 29 characters');

UPDATE fer_1
SET text_column = CONCAT(text_column, ', but now it is longer')
WHERE fer_id = 1;

SELECT CONCAT(first_name, ' ',last_name, ' ', 'has been a costumer since', ' ', date(create_date)) cust_narrative
FROM customer;

SELECT first_name + ' ' + last_name + ' ' + 'has been a customer since' + ' '# + date(create_date) cust_narrativee
FROM customer; #SOLO PARA SQL SERVER

SELECT INSERT('goodbye world', 9, 0, 'cruel ') string; #PARA REEMPLAZAR CARACTERES
SELECT INSERT('goodbye world', 1, 7, 'hello') string;

SELECT SUBSTRING('goodbye cruel world', 9, 5); #PARA EXTRAER CARACTERES

SELECT (37 * 59) / (78 - (8 * 6));

SELECT MOD(10,3); #TUY SABES QUE HACE %
SELECT MOD(22.75, 5);
SELECT POW(2,8);

SELECT POW(2,10) kilobyte, POW(2,20) megabyte,
POW(2,30) gigabyte, POW(2,40) terabyte;

SELECT CEIL(72.445), FLOOR(72.445); #REDONDEA

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);
SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3); #Lo mimso que round pero no redondea 
#SELECT ROUND(17, −1), TRUNCATE(17, −1);

CREATE TABLE things(
account_id SMALLINT,
acct_type VARCHAR(30),
balance VARCHAR(20),
PRIMARY KEY (account_id)
);

INSERT INTO things (account_id, acct_type, balance)
VALUES(123, 'MONEY MARKET', 785.22),
      (456, 'SAVINGS', 0.00),
      (789, 'CHECKING', -324.22);
      
SELECT * FROM account;

SELECT account_id, SIGN(balance), ABS(balance)
FROM things;

SELECT @@global.time_zone, @@session.time_zone;

SET time_zone = 'Mexico/Guadalajara'; #Revisar
SET time_zone = 'Europe/Zurich';

SELECT CAST('2019-09-17 15:30:00' AS DATETIME) datetime_field,
       CAST('2019-09-17' AS DATE) date_field, 
       CAST('108:17:57' AS TIME) time_field;
UPDATE rental
SET return_datee = STR_TO_DATE('September 17, 2019', '%M %d, %Y') #Revisar
WHERE rental_id = 99999;

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP(); #IMPORATANTE

USE sakila;
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY);

SELECT DAYNAME('2019-09-18');
SELECT DAYNAME('1997-01-24');

SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05');
SELECT EXTRACT(DAY FROM '2019-09-18 22:19:05');

SELECT DATEDIFF('2019-09-03', '2019-06-21');
SELECT DATEDIFF('2019-09-03 23:59:59', '2019-06-21 00:00:01');
SELECT DATEDIFF('2019-06-21', '2019-09-03');

SELECT CAST('1456328' AS SIGNED INTEGER);

SELECT CAST('999ABC111' AS UNSIGNED INTEGER);
show warnings;

SELECT SUBSTRING('PLEASE FIND THE SUBSTRING IN THIS STRING', 17, 9);

SELECT ABS(-25.76823), ROUND(-25.76823, 3), SIGN(-25.76823);

SELECT EXTRACT(MONTH FROM current_date()); #ends of chapter 7

SELECT customer_id, COUNT(*) NuM
FROM rental
GROUP BY customer_id
ORDER BY Num DESC; #En vez num puede ir el numero 2

SELECT customer_id, count(*) MaM #esta funcion no funcina 
FROM rental
WHERE MaM >= 40
GROUP BY customer_id;

SELECT customer_id, count(*)
FROM rental
GROUP BY customer_id
HAVING count(*) >= 40;

SHOW WARNINGS;

USE sakila;

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

USE sakila;
SELECT city_id, city
FROM city
WHERE country_id <> (SELECT country_id FROM country WHERE country = 'India');

SELECT country_id
FROM country
WHERE country IN ('Mexico', 'Canada');

SELECT country_id
FROM country
WHERE country = 'Canada' OR country = 'Mexico';

SELECT city_id, city
FROM city
WHERE country_id IN (SELECT country_id 
                     FROM country 
                     WHERE country IN ('Canada', 'Mexico'));

SELECT city_id, city #LO CONTRARIO DE LA ANTERIOR
FROM city
WHERE country_id NOT IN (SELECT country_id 
                     FROM country 
                     WHERE country IN ('Canada', 'Mexico'));

SELECT first_name, last_name
FROM customer
WHERE customer_id <> ALL (SELECT customer_id 
                          FROM payment 
                          WHERE amount = 0);
SELECT first_name, last_name
FROM customer
WHERE customer_id NOT IN (SELECT customer_id 
                          FROM payment 
                          WHERE amount = 0);
                                              
SELECT customer_id, COUNT(*)
FROM rental
GROUP BY customer_id
HAVING COUNT(*)  > ALL (SELECT COUNT(*)
						FROM rental r
                        INNER JOIN customer c
                        ON r.customer_id = c.customer_id
                        INNER JOIN address a
                        ON c.address_id = a.address_id
                        INNER JOIN city ct
                        ON a.city_id = ct.city_id
                        INNER JOIN country co
                        ON ct.country_id = co.country_id
                        WHERE co.country IN ('United States', 'Canada', 'Mexico')
                        GROUP BY r.customer_id
);

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > ANY (
SELECT sum(p.amount)
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country co
ON ct.country_id = co.country_id
WHERE co.country IN ('Bolivia','Paraguay','Chile')
GROUP BY co.country      );

SELECT fa.actor_id, fa.film_id
FROM film_actor fa
WHERE fa.actor_id IN (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
	AND fa.film_id IN (SELECT film_id FROM film WHERE rating = 'PG');

SELECT actor_id, film_id
FROM film_actor
WHERE (actor_id, film_id) IN (SELECT a.actor_id, f.film_id
							  FROM actor a
                              CROSS JOIN film f
							  WHERE a.last_name = 'MONROE' AND f.rating = 'PG');
 

USE sakila;
SELECT c.first_name, c.last_name
FROM customer c
WHERE 20 = (SELECT count(*) FROM rental r WHERE r.customer_id = c.customer_id);
 
SELECT c.first_name, c.last_name, c.customer_id
FROM customer c
WHERE (SELECT sum(p.amount) 
       FROM payment p 
       WHERE p.customer_id = c.customer_id) BETWEEN 180 AND 240;
 
SELECT c.first_name, c.last_name
FROM customer c
 WHERE EXISTS(SELECT r.rental_date, r.customer_id, 'ABCD' str, 2 * 3 / 7 nmbr
              FROM rental r
              WHERE r.customer_id = c.customer_id
              AND date(r.rental_date) < '2005-05-25');

SELECT a.first_name, a.last_name
FROM actor a
WHERE NOT EXISTS(SELECT 1
                 FROM film_actor fa
				 INNER JOIN film f ON f.film_id = fa.film_id
                 WHERE fa.actor_id = a.actor_id
                 AND f.rating = 'R');

 SELECT * FROM customer;
 
UPDATE customer c. #Quitar punto 
SET c.last_update = (SELECT max(r.rental_date) FROM rental r
                     WHERE r.customer_id = c.customer_id);

USE sakila;
SELECT c.first_name, c.last_name, pymnt.num_rentals, pymnt.tot_payments
FROM customer c
INNER JOIN (SELECT customer_id, count(*) num_rentals, sum(amount) tot_payments
            FROM payment
            GROUP BY customer_id) pymnt
ON c.customer_id = pymnt.customer_id;


SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

SELECT pymnt_grps.name, count(*) num_customers
FROM
(SELECT customer_id, count(*) num_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id) pymnt
INNER JOIN (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
            UNION ALL
			SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
            UNION ALL
            SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit
            ) pymnt_grps
ON pymnt.tot_payments BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
GROUP BY pymnt_grps.name;

SELECT c.first_name, c.last_name, ct.city, sum(p.amount) tot_payments, count(*) tot_rentals
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
GROUP BY c.first_name, c.last_name, ct.city;

SELECT customer_id, count(*) tot_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id;

SELECT c.first_name, c.last_name, ct.city, pymnt.tot_payments, pymnt.tot_rentals
FROM
(SELECT customer_id, count(*) tot_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id) pymnt
INNER JOIN customer c
ON pymnt.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id;

USE sakila;
WITH actors_s AS
(SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'S%'
),
 actors_s_pg AS
(SELECT s.actor_id, s.first_name, s.last_name,
f.film_id, f.title
FROM actors_s s
INNER JOIN film_actor fa
ON s.actor_id = fa.actor_id
 INNER JOIN film f
ON f.film_id = fa.film_id
WHERE f.rating = 'PG'
), actors_s_pg_revenue AS
(SELECT spg.first_name, spg.last_name, p.amount
FROM actors_s_pg spg
INNER JOIN inventory i
ON i.film_id = spg.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN payment p
ON r.rental_id = p.rental_id
) -- end of With clause
SELECT spg_rev.first_name, spg_rev.last_name,
sum(spg_rev.amount) tot_revenue
FROM actors_s_pg_revenue spg_rev
GROUP BY spg_rev.first_name, spg_rev.last_name
ORDER BY 3 desc;


SELECT (SELECT c.first_name 
        FROM customer c
        WHERE c.customer_id = p.customer_id
) first_name,(SELECT c.last_name 
              FROM customer c
              WHERE c.customer_id = p.customer_id
) last_name, (SELECT ct.city
              FROM customer c
			  INNER JOIN address a
              ON c.address_id = a.address_id
              INNER JOIN city ct
              ON a.city_id = ct.city_id
              WHERE c.customer_id = p.customer_id ) city,
sum(p.amount) tot_payments,
count(*) tot_rentals
FROM payment p
GROUP BY p.customer_id;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
ORDER BY (SELECT count(*) FROM film_actor fa
		  WHERE fa.actor_id = a.actor_id) DESC;

SELECT * FROM film;
SELECT * FROM category;
SELECT * FROM film_category;

SELECT film_id, title #mal mal
FROM film
WHERE film_id IN (SELECT c.category_id
                  FROM category c
                  WHERE c.name = 'Action')
ORDER BY film_id;


SELECT film_id, title
FROM film
WHERE film_id IN (SELECT fc.film_id
                  FROM film_category fc INNER JOIN category c
				  ON fc.category_id = c.category_id
				  WHERE c.name = 'Action');

SELECT f.title, f.film_id
FROM film f
WHERE EXISTS (SELECT 1
              FROM film_category fc INNER JOIN category c
              ON fc.category_id = c.category_id
              WHERE c.name = 'Action' AND fc.film_id = f.film_id);

SELECT * FROM film_actor;

SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles;

SELECT actr.actor_id, grps.level
FROM
(SELECT actor_id, count(*) num_roles
FROM film_actor
GROUP BY actor_id ) actr
INNER JOIN
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
 SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles ) grps
ON actr.num_roles BETWEEN grps.min_roles AND grps.max_roles;

USE sakila;
SELECT * FROM film;
SELECT * FROM inventory;

SELECT f.film_id, f.title, COUNT(*) count
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id;

SELECT f.film_id, f.title, COUNT(i.inventory_id) counts
FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id, f.title;

SELECT f.film_id, f.title, i.inventory_id
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id
FROM inventory i
RIGHT OUTER JOIN film f
ON i.film_id = f.film_id
WHERE f.film_id BETWEEN 13 AND 15;

SELECT f.film_id, f.title, i.inventory_id, r.rental_date
FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id 
LEFT OUTER JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE f.film_id BETWEEN 13 AND 15;

SELECT * FROM category;
SELECT * FROM language;

#SELECT c.name category_name, l.name lenguaje_name
SELECT l.name lenguaje_name, c.name category_name 
FROM category c
CROSS JOIN language l;

SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit;

USE sakila;
SELECT ones.num + tens.nums + hundreds.numse
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 90 nums UNION ALL
SELECT 80 nums UNION ALL
SELECT 70 nums UNION ALL
SELECT 60 nums UNION ALL
SELECT 50 nums UNION ALL
SELECT 40 nums UNION ALL
SELECT 30 nums UNION ALL
SELECT 20 nums UNION ALL
SELECT 10 nums UNION ALL
SELECT 00 nums) tens
CROSS JOIN 
(SELECT 0 numse UNION ALL
SELECT 100 numse UNION ALL
SELECT 200 numse UNION ALL
SELECT 300 numse UNION ALL
SELECT 400 numse UNION ALL
SELECT 500 numse UNION ALL
SELECT 600 numse UNION ALL
SELECT 700 numse UNION ALL
SELECT 800 numse UNION ALL
SELECT 900 numse ) hundreds;

SELECT DATE_ADD('2020-01-01', INTERVAL (ones.num + tens.nums + hundreds.numse) DAY) dt
FROM 
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 90 nums UNION ALL
SELECT 80 nums UNION ALL
SELECT 70 nums UNION ALL
SELECT 60 nums UNION ALL
SELECT 50 nums UNION ALL
SELECT 40 nums UNION ALL
SELECT 30 nums UNION ALL
SELECT 20 nums UNION ALL
SELECT 10 nums UNION ALL
SELECT 00 nums) tens
CROSS JOIN 
(SELECT 0 numse UNION ALL
SELECT 100 numse UNION ALL
SELECT 200 numse UNION ALL
SELECT 300 numse UNION ALL
SELECT 400 numse UNION ALL
SELECT 500 numse UNION ALL
SELECT 600 numse UNION ALL
SELECT 700 numse UNION ALL
SELECT 800 numse UNION ALL
SELECT 900 numse ) hundreds
WHERE DATE_ADD('2020-01-01', INTERVAL (ones.num + tens.nums + hundreds.numse) DAY) < '2021-01-01'
ORDER BY 1;

SELECT * FROM rental;

SELECT days.dt, COUNT(*) num_rentals
FROM rental r
RIGHT OUTER JOIN (
SELECT DATE_ADD('2005-01-01', INTERVAL (ones.num + tens.nums + hundreds.numse) DAY) dt
FROM 
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 90 nums UNION ALL
SELECT 80 nums UNION ALL
SELECT 70 nums UNION ALL
SELECT 60 nums UNION ALL
SELECT 50 nums UNION ALL
SELECT 40 nums UNION ALL
SELECT 30 nums UNION ALL
SELECT 20 nums UNION ALL
SELECT 10 nums UNION ALL
SELECT 00 nums) tens
CROSS JOIN 
(SELECT 0 numse UNION ALL
SELECT 100 numse UNION ALL
SELECT 200 numse UNION ALL
SELECT 300 numse UNION ALL
SELECT 400 numse UNION ALL
SELECT 500 numse UNION ALL
SELECT 600 numse UNION ALL
SELECT 700 numse UNION ALL
SELECT 800 numse UNION ALL
SELECT 900 numse ) hundreds
WHERE DATE_ADD('2005-01-01', INTERVAL (ones.num + tens.nums + hundreds.numse) DAY) < '2006-01-01'
) days
ON days.dt = DATE(r.rental_date)
GROUP BY days.dt
ORDER BY 1;

SELECT c.first_name, c.last_name, DATE(r.rental_date)
FROM customer c
NATURAL JOIN rental r;

SELECT cust.first_name, cust.last_name, DATE(r.rental_date)#, count(*)
FROM(SELECT customer_id, first_name, last_name
	 FROM customer) cust
NATURAL JOIN rental r;
#GROUP BY cust.first_name, cust.last_name;

SELECT * FROM customer;
SELECT * FROM payment;



SELECT 1 Customer_id, 'John Smith' Name UNION ALL
SELECT 2 Customer_id, 'Kathy Jones' Name UNION ALL
SELECT 3 Customer_id, 'Greg Oliver' Name;

SELECT 101 payment, 1 Customer_id, 8.99 Amount UNION ALL
SELECT 102 payment, 3 Customer_id, 4.99 Amount UNION ALL
SELECT 103 payment, 1 Customer_id, 7.99 Amount;

SELECT Nam.Name, SUM(fer.amount)
FROM (SELECT 1 Customer_id, 'John Smith' Name UNION ALL
      SELECT 2 Customer_id, 'Kathy Jones' Name UNION ALL
      SELECT 3 Customer_id, 'Greg Oliver' Name) Nam
LEFT OUTER JOIN (SELECT 101 payment, 1 Customer_id, 8.99 Amount UNION ALL
                 SELECT 102 payment, 3 Customer_id, 4.99 Amount UNION ALL
                 SELECT 103 payment, 1 Customer_id, 7.99 Amount) fer
ON Nam.Customer_id = fer.Customer_id
GROUP BY Nam.Name;

SELECT Nam.Name, SUM(fer.amount)
FROM (SELECT 101 payment, 1 Customer_id, 8.99 Amount UNION ALL
                 SELECT 102 payment, 3 Customer_id, 4.99 Amount UNION ALL
                 SELECT 103 payment, 1 Customer_id, 7.99 Amount) fer

RIGHT OUTER JOIN (SELECT 1 Customer_id, 'John Smith' Name UNION ALL
      SELECT 2 Customer_id, 'Kathy Jones' Name UNION ALL
      SELECT 3 Customer_id, 'Greg Oliver' Name) Nam
ON Nam.Customer_id = fer.Customer_id
GROUP BY Nam.Name;


SELECT ones.num + tens.nums + 1 SUM
FROM
(SELECT 9 nums UNION ALL
SELECT 8 nums UNION ALL
SELECT 7 nums UNION ALL
SELECT 6 nums UNION ALL
SELECT 5 nums UNION ALL
SELECT 4 nums UNION ALL
SELECT 3 nums UNION ALL
SELECT 2 nums UNION ALL
SELECT 1 nums UNION ALL
SELECT 0 nums) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) ones;

USE sakila;
SELECT first_name, last_name,
CASE 
 WHEN active = 1 THEN 'ACTIVE' ELSE 'INACTIVE'
END AS activity_type
FROM customer;

#EJEMPLO_inicio
CASE 
 WHEN category.name IN ('Children', 'Family', 'Sports', 'Animation')
   THEN 'All CATEGORIES'
 WHEN catergory.name = 'Horror'
   THEN 'Adult'
 WHEN category.name = IN ('Music', 'Game')
   THEN 'Teens'
 ELSE 'Other'
END
#EJEMPLO_final

SELECT c.first_name, c.last_name,
 CASE
  WHEN active = 0 THEN 0
  ELSE (SELECT COUNT(*) FROM rental r
        WHERE r.customer_id = c.customer_id)
 END fer
FROM customer c;

SELECT * FROM customer;

SELECT MONTHNAME(rental_date) rental_month, COUNT(*) num_rentals
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01'
GROUP BY MONTHNAME(rental_date);

SELECT MONTHNAME('2007-01-24');

SELECT 
SUM(CASE WHEN MONTHNAME(rental_date) = 'May' THEN 1 ELSE 0 END) may_rentals,
SUM(CASE WHEN MONTHNAME(rental_date) = 'June' THEN 1 ELSE 0 END) June_rentals,
SUM(CASE WHEN MONTHNAME(rental_date) = 'July' THEN 1 ELSE 0 END) July_rantals
FROM rental 
WHERE rental_date BETWEEN '2005-05-01' AND '2005-08-01';

SELECT a.first_name, a.last_name,
CASE 
 WHEN EXISTS (SELECT 1 FROM film_actor fa
			  INNER JOIN film f 
              ON fa.film_id = f.film_id
              WHERE fa.actor_id = a.actor_id AND f.rating = 'G') THEN 'Y'
 ELSE 'N'
END g_actor,
CASE
 WHEN EXISTS (SELECT 1 FROM film_actor fa
			  INNER JOIN film f 
              ON fa.film_id = f.film_id
              WHERE fa.actor_id = a.actor_id AND f.rating = 'PG') THEN 'Y'
 ELSE 'N'
END pg_actor,
CASE 
 WHEN EXISTS (SELECT 1 FROM film_actor fa
              INNER JOIN film f 
              ON fa.film_id = f.film_id
              WHERE fa.actor_id = a.actor_id AND f.rating = 'NC-17') THEN 'Y'
 ELSE 'N'
END nc17_actor
FROM actor a
WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';
 
SELECT f.title, 
CASE (SELECT COUNT(*) FROM inventory i WHERE i.film_id = f.film_id)
 WHEN 0 THEN 'Out of stock'
 WHEN 1 THEN 'Scarce'
 WHEN 2 THEN 'Scarce'
 WHEN 3 THEN 'Available'
 WHEN 4 THEN 'Available'
 ELSE 'Common'
END film_available
FROM film f;

SELECT c.first_name, c.last_name, SUM(p.amount) total_payment, COUNT(p.amount) num_payments,
	   SUM(p.amount)/CASE WHEN COUNT(p.amount) = 0 THEN 1 ELSE COUNT(p.amount) END avg_payment
FROM customer c
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;

SELECT 100 / 0;
USE sakila;

SELECT NOW();
select * from customer;

UPDATE customer. #No correr-solo ejemplo
SET active =
 CASE
 WHEN 90 <= (SELECT datediff(now(), max(rental_date))
 FROM rental r
 WHERE r.customer_id = customer.customer_id)
 THEN 0
 ELSE 1
 END
WHERE active = 1;

SELECT c.first_name, c.last_name,. #No correr solo ejemplo
 CASE
 WHEN a.address IS NULL THEN 'Unknown'
 ELSE a.address
 END address,
 CASE
 WHEN ct.city IS NULL THEN 'Unknown'
 ELSE ct.city
 END city,
 CASE
 WHEN cn.country IS NULL THEN 'Unknown'
 ELSE cn.country
 END country
FROM customer c
 LEFT OUTER JOIN address a
 ON c.address_id = a.address_id
 LEFT OUTER JOIN city ct
 ON a.city_id = ct.city_id
 LEFT OUTER JOIN country cn
 ON ct.country_id = cn.country_id;

SELECT name,
 CASE name
 WHEN 'English' THEN 'latin1'
 WHEN 'Italian' THEN 'latin1'
 WHEN 'French' THEN 'latin1'
 WHEN 'German' THEN 'latin1'
 WHEN 'Japanese' THEN 'utf8'
 WHEN 'Mandarin' THEN 'utf8'
 ELSE 'Unknown'
 END character_set
FROM language;

SELECT name, CASE 
			  WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'latin1'
              WHEN name IN ('Japanese', 'Mandarin') THEN 'utf8'
              ELSE 'Unknown'
			 END character_set
FROM language;
               
SELECT rating, count(*)
FROM film
GROUP BY rating;

#SELECT * FROM film;

SELECT SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) PG_rating,
	   SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) G_rating,
       SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) NC_17_rating,
       SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) PG_13_rating,
       SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) R_rating
FROM film;

SET AUTOCOMMIT=1;

USE sakila;
show table status like 'customer';
SELECT * FROM customer;

SAVEPOINT FERFER;
ROLLBACK TO SAVEPOINT FERFER;

SELECT 123 account_id, 500 avail_balance, convert('2019-07-10-20-53-27', datetime) last_activity_date
UNION ALL
SELECT 789 account_id, 75 avail_balance, convert('2019-06-22-15-18-35', datetime) last_activity_date;

SELECT 1001 txn_id, 2019-05-15 txn_date, 123 account_id, 'C' txn_type_cd, 500 amount
UNION ALL
SELECT 1002 txn_id, 2019-06-01 txn_date, 789 account_id, 'C' txn_type_cd, 75 amount;

SELECT first_name, last_name
FROM customer
WHERE last_name LIKE 'Y%';

SELECT * FROM customer;

ALTER TABLE customer
ADD INDEX idx_email(email);

SHOW INDEX FROM customer;

ALTER TABLE customer 
DROP index idxemail;

ALTER TABLE customer
ADD UNIQUE idxemail(email);

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
VALUES (1,'ALAN','KAHN', 'ALAN.KAHN@sakilacustomer.org', 394, 1);

DELETE FROM customer WHERE customer_id = 601;

SELECT * FROM customer WHERE email='ALAN.KAHN@sakilacustomer.org';

ALTER TABLE customer
ADD INDEX idx_full_name (last_name, first_name);

USE sakila;

EXPLAIN
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

SELECT * FROM customer;
DESCRIBE customer;
SHOW INDEX FROM customer;

SELECT c.first_name, c.last_name, c.address_id, a.address
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
WHERE a.address_id = 123;

DELETE FROM address WHERE address_id = 123;

UPDATE address
SET address_id = 9999
WHERE address_id = 123;

SELECT * FROM address;

SELECT c.first_name, c.last_name, c.address_id, a.address
FROM customer c
INNER JOIN address a
ON a.address_id = c.address_id
WHERE a.address_id = 9999;

ALTER TABLE rental. #no correr solo es un ejejmplo
ADD CONSTRAINT fk_rental_custoer_id FOREIGN KEY (customer_id)
REFERENCES customer (customer_id) ON DELETE RESTRICT;

CREATE INDEX idx_payment01. #no correr solo es un ejejmplo
ON payment (payment_dtae, amount);

#Here begin view's 
USE sakila;

CREATE VIEW customer_vw (customer_id, first_nmae, last_name, email)
AS SELECT customer_id, first_name, last_name, CONCAT(SUBSTR(email, 1, 2), '*****', SUBSTR(email, -4)) email
FROM customer;

SELECT customer_id, last_name, first_nmae, email
FROM customer_vw;

DESCRIBE customer_vw;

SELECT first_nmae, COUNT(*), MIN(last_name), MAX(last_name)
FROM customer_vw
WHERE first_nmae LIKE 'J%'
GROUP BY first_nmae
HAVING COUNT(*) > 1
order by 1;

SELECT first_nmae, COUNT(*), last_name, last_name
FROM customer_vw
WHERE first_nmae LIKE 'J%'
GROUP BY first_nmae
#HAVING COUNT(*) > 1
order by 1;

SELECT cv.first_nmae, cv.last_name, p.amount
FROM customer_vw cv
INNER JOIN payment p
ON cv.customer_id = p.customer_id
WHERE p.amount  >= 11
ORDER BY 1;

CREATE VIEW active_customer_vw(customer_d, first_name, last_naem, email)
AS SELECT custom,er_id, first_name , last_name, CONCAT(SUBSTR(email, 1, 2), '*****', CONCAT(email, -4)) email
FROM csutomer
WHERE active = 1;

CREATE VIEW sales_by_film_category
AS SELECT c.name AS category, SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_sales DESC;

CREATE VIEW film_stats
AS SELECT f.film_id, f.title, f.description, f.rating,
 (SELECT c.name
 FROM category c
 INNER JOIN film_category fc
 ON c.category_id = fc.category_id
 WHERE fc.film_id = f.film_id) category_name,
 (SELECT count(*)
 FROM film_actor fa
 WHERE fa.film_id = f.film_id
 ) num_actors,
 (SELECT count(*)
 FROM inventory i
 WHERE i.film_id = f.film_id
 ) inventory_cnt,
 (SELECT count(*)
 FROM inventory i
 INNER JOIN rental r
 ON i.inventory_id = r.inventory_id
 WHERE i.film_id = f.film_id
 ) num_rentals
FROM film f;

CREATE VIEW payment_all (payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update ) #Just example
AS SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM payment_historic
UNION ALL
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM payment_current;

USE sakila;
UPDATE customer_vw
SET last_name = 'SMITH-ALLEN'
WHERE customer_id = 1;

SELECT first_nmae, last_name, email
FROM customer_vw
WHERE customer_id = 1;

UPDATE customer_vw
SET email = 'MARY.SMITH-ALLEN@sakilacustomer.org'
WHERE customer_id = 1;

INSERT INTO customer_vw
(customer_id, first_nmae, last_name)
VALUES (99999, 'ROBERT', 'SIMPSON');

CREATE VIEW customer_details 
AS SELECT c.customer_id, c.store_id, c.first_name, c.last_name, c.address_id, c.active, c.create_date, a.address, ct.city, cn.country, a.postal_code
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country cn
ON 	ct.country_id = cn.country_id;

SELECT * FROM customer_details
ORDER BY customer_id;

UPDATE customer_details
SET last_name = 'SMITH-ALLENN', active = 0
WHERE customer_id = 1;

UPDATE customer_details
SET address = '999 Mockingbird Lane'
WHERE customer_id = 1;

UPDATE customer_details
SET last_name = 'SMITH-ALLEN', active = 1, address = '999 Mockingbird Lane'
WHERE customer_id = 1;

INSERT INTO customer_details (customer_id, store_id, first_name, last_name, address_id, active, create_date)
VALUES (9999, 1, 'BRIAN', 'SALAZAR', 5, 1, now());

SELECT * FROM customer_details
ORDER BY customer_id DESC;

INSERT INTO customer_details (customer_id, store_id, first_name, last_name, address_id, active, create_date, address)
VALUES (9999, 2, 'THOMAS', 'BISHOP', 7, 1, now(), '999 Mockingbird Lane');

CREATE VIEW film_ctgy_actor
AS SELECT f.title, c.name, first_name, last_name
FROM film f
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON c.category_id = fc.category_id
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor a
ON a.actor_id = fa.actor_id;
#WHERE (first_name = 'BOB' AND last_name = 'FAWCETT') OR (first_name = 'JULIA' AND last_name = 'FAWCETT');

DROP VIEW film_ctgy_actor;

SELECT * FROM film_ctgy_Actor
WHERE last_name = 'FAWCETT';

SELECT * FROM country;
SELECT * FROM payment;
SELECT * FROM customer;

CREATE VIEW new_view_pay
AS SELECT c.country, ctm.customer_id, pay.tot_payment
FROM country c
INNER JOIN city ct
ON c.country_id = ct.country_id
INNER JOIN address a
ON ct.city_id = a.city_id
INNER JOIN customer ctm
ON a.address_id = ctm.address_id
INNER JOIN (SELECT customer_id, SUM(amount) tot_payment FROM payment GROUP BY customer_id) pay
ON ctm.customer_id = pay.customer_id;

SELECT * FROM new_view_pay;

SELECT country, SUM(tot_payment)
FROM new_view_pay
GROUP BY country;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;

CREATE VIEW country_payments
AS
SELECT c.country,
 (SELECT sum(p.amount)
 FROM city ct
 INNER JOIN address a
 ON ct.city_id = a.city_id
 INNER JOIN customer cst
 ON a.address_id = cst.address_id
 INNER JOIN payment p
 ON cst.customer_id = p.customer_id
 WHERE ct.country_id = c.country_id
 ) tot_payments
FROM country c;

SELECT * FROM country_payments;
#HERE'S END VIEWS 

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila' AND table_type = 'BASE TABLE'
ORDER BY 1;

SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT column_name, data_type, character_maximum_length char_max_len, 
	   numeric_precision num_prcsn, numeric_scale num_scale
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'film'
ORDER BY ordinal_position;

SELECT index_name, non_unique, seq_in_index, column_name
FROM information_schema.statistics
WHERE table_schema = 'sakila' AND table_name = 'rental'
ORDER BY 1, 3;

SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'sakila'
ORDER BY 3,1;

USE sakila;

SELECT * FROM category;

SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM (SELECT concat(' ',column_name, ' ', column_type,

CASE WHEN is_nullable = 'NO' THEN ' not null'
ELSE ''
END,
CASE WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%' THEN concat(' DEFAULT ',column_default,substr(extra,18))
WHEN extra IS NOT NULL THEN concat(' ', extra)
ELSE ''
END, ',') txt

FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'category'
ORDER BY ordinal_position ) cols
UNION ALL
SELECT ')';

SELECT 'CREATE TABLE category (' create_table_statement
UNION ALL
SELECT cols.txt
FROM (SELECT concat(' ',column_name, ' ', column_type,
CASE WHEN is_nullable = 'NO' THEN ' not null'
ELSE ''
END,
CASE WHEN extra IS NOT NULL AND extra LIKE 'DEFAULT_GENERATED%' THEN concat(' DEFAULT ',column_default,substr(extra,18))
WHEN extra IS NOT NULL THEN concat(' ', extra)
ELSE ''
END, ',') txt
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'category'
ORDER BY ordinal_position ) cols
UNION ALL
SELECT concat(' constraint primary key (')
FROM information_schema.table_constraints
WHERE table_schema = 'sakila' AND table_name = 'category'
AND constraint_type = 'PRIMARY KEY'
UNION ALL
SELECT cols.txt
FROM (SELECT concat(CASE WHEN ordinal_position > 1 THEN ' ,'
ELSE ' ' END, column_name) txt
FROM information_schema.key_column_usage
WHERE table_schema = 'sakila' AND table_name = 'category' AND constraint_name = 'PRIMARY'
ORDER BY ordinal_position ) cols
UNION ALL
SELECT ' )'
UNION ALL
SELECT ')';

CREATE TABLE category2 (
 category_id tinyint unsigned not null auto_increment,
 name varchar(25) not null ,
 last_update timestamp not null DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
 constraint primary key (
 category_id
 ) )

SELECT tbl.table_name,
(SELECT count(*) FROM information_schema.columns clm
WHERE clm.table_schema = tbl.table_schema AND clm.table_name = tbl.table_name) num_columns,
(SELECT count(*) FROM information_schema.statistics sta
WHERE sta.table_schema = tbl.table_schema AND sta.table_name = tbl.table_name) num_indexes,
(SELECT count(*) FROM information_schema.table_constraints tc
WHERE tc.table_schema = tbl.table_schema AND tc.table_name = tbl.table_name
                                         AND tc.constraint_type = 'PRIMARY KEY') num_primary_keys
FROM information_schema.tables tbl
WHERE tbl.table_schema = 'sakila' AND tbl.table_type = 'BASE TABLE'
ORDER BY 1;

USE sakila;
SET @qry = 'SELECT customer_id, first_name, last_name FROM customer';
PREPARE dynsql1 FROM @qry;
EXECUTE dynsql1;

DEALLOCATE PREPARE dynsql1;

SET @qry = 'SELECT customer_id, first_name, last_name FROM customer WHERE customer_id = ?';
PREPARE dynsql2 FROM @qry;
SET @custid = 9;
EXECUTE dynsql2 USING @custid;
#SET @custid = 145;
#EXECUTE dynsql2 USING @custid;
DEALLOCATE PREPARE dynsql2;

SELECT concat('SELECT ', concat_ws(',', cols.col1, cols.col2, cols.col3, 
                                        cols.col4, cols.col5, cols.col6, 
                                        cols.col7, cols.col8, cols.col9),
			  ' FROM customer WHERE customer_id = ?')
INTO @qry
FROM (SELECT
max(CASE WHEN ordinal_position = 1 THEN column_name
ELSE NULL END) col1,
max(CASE WHEN ordinal_position = 2 THEN column_name
ELSE NULL END) col2,
max(CASE WHEN ordinal_position = 3 THEN column_name
ELSE NULL END) col3,
max(CASE WHEN ordinal_position = 4 THEN column_name
ELSE NULL END) col4,
max(CASE WHEN ordinal_position = 5 THEN column_name
ELSE NULL END) col5,
max(CASE WHEN ordinal_position = 6 THEN column_name
 ELSE NULL END) col6,
max(CASE WHEN ordinal_position = 7 THEN column_name
ELSE NULL END) col7,
max(CASE WHEN ordinal_position = 8 THEN column_name
ELSE NULL END) col8,
max(CASE WHEN ordinal_position = 9 THEN column_name
ELSE NULL END) col9
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'customer'
GROUP BY table_name
) cols;

SELECT @qry;
PREPARE dynsql3 FROM @qry;
SET @custid = 45;
EXECUTE dynsql3 USING @custid;
DEALLOCATE PREPARE dynsql3;

SELECT
max(CASE WHEN ordinal_position = 1 THEN column_name
ELSE NULL END) col1,
max(CASE WHEN ordinal_position = 2 THEN column_name
ELSE NULL END) col2,
max(CASE WHEN ordinal_position = 3 THEN column_name
ELSE NULL END) col3,
max(CASE WHEN ordinal_position = 4 THEN column_name
ELSE NULL END) col4,
max(CASE WHEN ordinal_position = 5 THEN column_name
ELSE NULL END) col5,
max(CASE WHEN ordinal_position = 6 THEN column_name
 ELSE NULL END) col6,
max(CASE WHEN ordinal_position = 7 THEN column_name
ELSE NULL END) col7,
max(CASE WHEN ordinal_position = 8 THEN column_name
ELSE NULL END) col8,
max(CASE WHEN ordinal_position = 9 THEN column_name
ELSE NULL END) col9,
max(CASE WHEN ordinal_position = 10 THEN column_name
ELSE NULL END) col10
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'customer'
GROUP BY table_name;

SELECT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT DISTINCT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'sakila'
ORDER BY 1;

 SELECT concat('ALTER TABLE ', table_name, ' ADD INDEX ',
               index_name, ' (', group_concat(column_name order by seq_in_index separator ', '), ');' 
               ) index_creation_statement
FROM information_schema.statistics
WHERE table_schema = 'sakila'
AND table_name = 'customer'
GROUP BY table_name, index_name;

##AUQI COMIENZA AS FUNCIONES ANALITICAS

SELECT payment_date, QUARTER(payment_date) quarter, MONTHNAME(payment_date) month_nm, SUM(amount) monthly_sales
FROM payment
WHERE YEAR(payment_date) = 2005
GROUP BY quarter, month_nm;

SELECT QUARTER(payment_date) quarter, MONTHNAME(payment_date) month_nm, SUM(amount) monthly_sales, 
       MAX(SUM(amount)) over () max_overall_sales,
       MAX(SUM(amount)) over (partition by quarter(payment_date)) max_qrtr_sales
FROM payment
WHERE YEAR(payment_date) = 2005
GROUP BY quarter, month_nm;

USE sakila;

SELECT quarter(payment_date) quarter, 
       monthname(payment_date) month_nm,
	   sum(amount) monthly_sales, 
       rank() over (order by sum(amount) desc) sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date)
ORDER BY 1, month(payment_date);

SELECT quarter(payment_date) quarter, 
       monthname(payment_date) month_nm, 
       sum(amount) monthly_sales,
       rank() over (partition by quarter(payment_date) order by sum(amount) desc) qtr_sales_rank
FROM payment
WHERE year(payment_date) = 2005
GROUP BY quarter(payment_date), monthname(payment_date)
ORDER BY 1, month(payment_date);

SELECT customer_id, COUNT(*)  num_rentals
FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;

SELECT customer_id, count(*) num_rentals,
	   row_number() over (order by count(*) desc) row_number_rnk,
       rank()       over (order by count(*) desc) rank_rnk,
       dense_rank() over (order by count(*) desc) dense_rank_rnk
FROM rental
GROUP BY customer_id
ORDER BY 2 desc;

SELECT customer_id, monthname(rental_date) rental_month,
	   count(*) num_rentals
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

SELECT customer_id, monthname(rental_date) rental_month,
	   count(*) num_rentals,
	   rank() over (partition by monthname(rental_date) ORDER BY count(*) desc) rank_rnk
FROM rental
GROUP BY customer_id, monthname(rental_date)
ORDER BY 2, 3 desc;

SELECT customer_id, rental_month, num_rentals, rank_rnk ranking
FROM
(SELECT customer_id, monthname(rental_date) rental_month,
		count(*) num_rentals,
        rank() over (partition by monthname(rental_date) order by count(*) desc) rank_rnk
 FROM rental
 GROUP BY customer_id, monthname(rental_date)
) cust_rankings
WHERE rank_rnk <= 5
ORDER BY rental_month, num_rentals desc, rank_rnk;

SELECT monthname(payment_date) payment_month, amount,
       sum(amount) over (partition by monthname(payment_date)) monthly_total,
       sum(amount) over () grand_total
FROM payment
WHERE amount >= 10
ORDER BY 1;

SELECT monthname(payment_date) payment_month,
       sum(amount) month_total,
       round(sum(amount) / sum(sum(amount)) over () * 100, 2) pct_of_total
FROM payment
GROUP BY monthname(payment_date);

SELECT monthname(payment_date) payment_month,
       sum(amount) month_total,
       CASE sum(amount)
        WHEN max(sum(amount)) over () THEN 'Highest'
		WHEN min(sum(amount)) over () THEN 'Lowest'
        ELSE 'Middle'
	   END descriptor
FROM payment
GROUP BY monthname(payment_date);

SELECT yearweek(payment_date) payment_week,
       sum(amount) week_total,
	   sum(sum(amount)) over (order by yearweek(payment_date) rows unbounded preceding) rolling_sum
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
       sum(amount) week_total,
       avg(sum(amount)) over (order by yearweek(payment_date) 
       rows between 1 preceding and 1 following) rolling_3wk_avg
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT date(payment_date), sum(amount),
       avg(sum(amount)) over (order by date(payment_date) range between interval 3 day preceding
						and interval 3 day following) 7_day_avg
FROM payment
WHERE payment_date BETWEEN '2005-07-01' AND '2005-09-01'
GROUP BY date(payment_date)
ORDER BY 1;

USE sakila;

SELECT yearweek(payment_date) payment_week,
       sum(amount) week_total, 
       lag(sum(amount), 1) over (order by yearweek(payment_date)) prev_wk_tot,
       lead(sum(amount), 1) over (order by yearweek(payment_date)) next_wk_tot
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT yearweek(payment_date) payment_week,
       sum(amount) week_total,
       round((sum(amount) - lag(sum(amount), 1) over (order by yearweek(payment_date))) 
        / lag(sum(amount), 1) over (order by yearweek(payment_date)) * 100, 1) pct_diff
FROM payment
GROUP BY yearweek(payment_date)
ORDER BY 1;

SELECT f.title, 
       group_concat(a.last_name order by a.last_name separator ', ') actors, COUNT(*) FER
FROM actor a
INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY f.title
HAVING count(*) = 3;

SELECT * FROM sales_by_film_category;
SELECT * FROM sales_by_store;

SELECT SUM(total_sales) FROM sales_by_film_category;

USE sakila;

CREATE TABLE sales
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
amount DECIMAL(9,2))
PARTITION BY RANGE (yearweek(sale_date))
(PARTITION s1 VALUES LESS THAN (202002),
PARTITION s2 VALUES LESS THAN (202003),
PARTITION s3 VALUES LESS THAN (202004),
PARTITION s4 VALUES LESS THAN (202005),
PARTITION s5 VALUES LESS THAN (202006),
PARTITION s999 VALUES LESS THAN (MAXVALUE));

DESC sales;
SELECT * FROM sales;

SELECT partition_name, partition_method, partition_expression
FROM information_schema.partitions
WHERE table_name = 'sales'
ORDER BY partition_ordinal_position;

ALTER TABLE sales REORGANIZE PARTITION s999 INTO #QUITAR PUNTO
 (PARTITION s6 VALUES LESS THAN (202007),
 PARTITION s7 VALUES LESS THAN (202008),
 PARTITION s999 VALUES LESS THAN (MAXVALUE));

INSERT INTO sales
VALUES (1, 1, 1, '2020-01-18', 2765.15), (2, 3, 4, '2020-02-07', 5322.08);

SELECT * FROM sales PARTITION (s2);

SELECT concat('# of rows in S1 = ', count(*)) partition_rowcount
FROM sales PARTITION (s1) UNION ALL
SELECT concat('# of rows in S2 = ', count(*)) partition_rowcount
FROM sales PARTITION (s2) UNION ALL
SELECT concat('# of rows in S3 = ', count(*)) partition_rowcount
FROM sales PARTITION (s3) UNION ALL
SELECT concat('# of rows in S4 = ', count(*)) partition_rowcount
FROM sales PARTITION (s4) UNION ALL
SELECT concat('# of rows in S5 = ', count(*)) partition_rowcount
FROM sales PARTITION (s5) UNION ALL
SELECT concat('# of rows in S6 = ', count(*)) partition_rowcount
FROM sales PARTITION (s6) UNION ALL
SELECT concat('# of rows in S7 = ', count(*)) partition_rowcount
FROM sales PARTITION (s7) UNION ALL
SELECT concat('# of rows in S999 = ', count(*)) partition_rowcount
FROM sales PARTITION (s999);


CREATE TABLE sales1
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
geo_region_cd VARCHAR(6) NOT NULL,
amount DECIMAL(9,2))
PARTITION BY LIST COLUMNS (geo_region_cd)
(PARTITION NORTHAMERICA VALUES IN ('US_NE','US_SE','US_MW',
'US_NW','US_SW','CAN','MEX'),
PARTITION EUROPE VALUES IN ('EUR_E','EUR_W'),
PARTITION ASIA VALUES IN ('CHN','JPN','IND'));

DESC sales1;
SELECT * FROM sales1;

INSERT INTO sales1
VALUES  (1, 1, 1, '2020-01-18', 'US_NE', 2765.15),
        (2, 3, 4, '2020-02-07', 'CAN', 5322.08), 
        (3, 6, 27, '2020-03-11', 'KOR', 4267.12);
        
ALTER TABLE sales1 REORGANIZE PARTITION ASIA INTO
(PARTITION ASIA VALUES IN ('CHN','JPN','IND', 'KOR'));

SELECT * FROM sales1 PARTITION (NORTHAMERICA)
UNION ALL
SELECT * FROM sales1 PARTITION (EUROPE)
UNION ALL
SELECT * FROM sales1 PARTITION (ASIA);

SELECT partition_name, partition_expression,
       partition_description
FROM information_schema.partitions
WHERE table_name = 'sales1'
ORDER BY partition_ordinal_position;

USE sakila;
DROP TABLE sales;

CREATE TABLE sales
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
 amount DECIMAL(9,2) )
PARTITION BY RANGE (yearweek(sale_date))
(PARTITION s1 VALUES LESS THAN (202002),
PARTITION s2 VALUES LESS THAN (202003),
PARTITION s3 VALUES LESS THAN (202004),
PARTITION s4 VALUES LESS THAN (202005),
PARTITION s5 VALUES LESS THAN (202006),
PARTITION s999 VALUES LESS THAN (MAXVALUE));

SELECT * FROM sales;

SELECT partition_name, partition_method, partition_expression
FROM information_schema.partitions
WHERE table_name = 'sales'
ORDER BY partition_ordinal_position;

ALTER TABLE sales REORGANIZE PARTITION s999 INTO
(PARTITION s6 VALUES LESS THAN (202007),
PARTITION s7 VALUES LESS THAN (202008),
PARTITION s999 VALUES LESS THAN (MAXVALUE));

INSERT INTO sales
VALUES (1, 1, 1, '2020-01-18', 2765.15), (2, 3, 4, '2020-02-07', 5322.08);

SELECT * FROM sales;

SELECT concat('# of rows in S1 = ', count(*)) partition_rowcount
FROM sales PARTITION (s1) UNION ALL
SELECT concat('# of rows in S2 = ', count(*)) partition_rowcount
FROM sales PARTITION (s2) UNION ALL
SELECT concat('# of rows in S3 = ', count(*)) partition_rowcount
FROM sales PARTITION (s3) UNION ALL
SELECT concat('# of rows in S4 = ', count(*)) partition_rowcount
FROM sales PARTITION (s4) UNION ALL
SELECT concat('# of rows in S5 = ', count(*)) partition_rowcount
FROM sales PARTITION (s5) UNION ALL
SELECT concat('# of rows in S6 = ', count(*)) partition_rowcount
FROM sales PARTITION (s6) UNION ALL
SELECT concat('# of rows in S7 = ', count(*)) partition_rowcount
FROM sales PARTITION (s7) UNION ALL
SELECT concat('# of rows in S999 = ', count(*)) partition_rowcount
FROM sales PARTITION (s999);

 CREATE TABLE sales
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
amount DECIMAL(9,2))
PARTITION BY HASH (cust_id)
PARTITIONS 4
(PARTITION H1, PARTITION H2, PARTITION H3, PARTITION H4);

INSERT INTO sales
VALUES
(1, 1, 1, '2020-01-18', 1.1), (2, 3, 4, '2020-02-07', 1.2),
(3, 17, 5, '2020-01-19', 1.3), (4, 23, 2, '2020-02-08', 1.4),
(5, 56, 1, '2020-01-20', 1.6), (6, 77, 5, '2020-02-09', 1.7),
(7, 122, 4, '2020-01-21', 1.8), (8, 153, 1, '2020-02-10', 1.9),
(9, 179, 5, '2020-01-22', 2.0), (10, 244, 2, '2020-02-11', 2.1),
(11, 263, 1, '2020-01-23', 2.2), (12, 312, 4, '2020-02-12', 2.3),
(13, 346, 2, '2020-01-24', 2.4), (14, 389, 3, '2020-02-13', 2.5),
(15, 472, 1, '2020-01-25', 2.6), (16, 502, 1, '2020-02-14', 2.7);

SELECT * FROM sales;

SELECT concat('# of rows in H1 = ', count(*)) partition_rowcount
FROM sales PARTITION (h1) UNION ALL
SELECT concat('# of rows in H2 = ', count(*)) partition_rowcount
FROM sales PARTITION (h2) UNION ALL
SELECT concat('# of rows in H3 = ', count(*)) partition_rowcount
FROM sales PARTITION (h3) UNION ALL
SELECT concat('# of rows in H4 = ', count(*)) partition_rowcount
FROM sales PARTITION (h4);

CREATE TABLE sales
(sale_id INT NOT NULL,
cust_id INT NOT NULL,
store_id INT NOT NULL,
sale_date DATE NOT NULL,
amount DECIMAL(9,2))
PARTITION BY RANGE (yearweek(sale_date))
SUBPARTITION BY HASH (cust_id)
(PARTITION s1 VALUES LESS THAN (202002)
(SUBPARTITION s1_h1,
SUBPARTITION s1_h2,
SUBPARTITION s1_h3,
SUBPARTITION s1_h4),
PARTITION s2 VALUES LESS THAN (202003)
(SUBPARTITION s2_h1,
SUBPARTITION s2_h2,
SUBPARTITION s2_h3,
SUBPARTITION s2_h4),
PARTITION s3 VALUES LESS THAN (202004)
(SUBPARTITION s3_h1,
SUBPARTITION s3_h2,
SUBPARTITION s3_h3,
SUBPARTITION s3_h4),
PARTITION s4 VALUES LESS THAN (202005)
(SUBPARTITION s4_h1,
SUBPARTITION s4_h2,
SUBPARTITION s4_h3,
SUBPARTITION s4_h4),
PARTITION s5 VALUES LESS THAN (202006)
(SUBPARTITION s5_h1,
SUBPARTITION s5_h2,
SUBPARTITION s5_h3,
SUBPARTITION s5_h4),
PARTITION s999 VALUES LESS THAN (MAXVALUE)
(SUBPARTITION s999_h1,
SUBPARTITION s999_h2,
SUBPARTITION s999_h3,
SUBPARTITION s999_h4));

INSERT INTO sales
VALUES
(1, 1, 1, '2020-01-18', 1.1), (2, 3, 4, '2020-02-07', 1.2),
(3, 17, 5, '2020-01-19', 1.3), (4, 23, 2, '2020-02-08', 1.4),
(5, 56, 1, '2020-01-20', 1.6), (6, 77, 5, '2020-02-09', 1.7),
(7, 122, 4, '2020-01-21', 1.8), (8, 153, 1, '2020-02-10', 1.9),
(9, 179, 5, '2020-01-22', 2.0), (10, 244, 2, '2020-02-11', 2.1),
(11, 263, 1, '2020-01-23', 2.2), (12, 312, 4, '2020-02-12', 2.3),
(13, 346, 2, '2020-01-24', 2.4), (14, 389, 3, '2020-02-13', 2.5),
(15, 472, 1, '2020-01-25', 2.6), (16, 502, 1, '2020-02-14', 2.7);

SELECT * FROM sales ORDER BY sale_id;
SELECT * FROM sales PARTITION (s3);
SELECT * FROM sales PARTITION (s3_H3);



