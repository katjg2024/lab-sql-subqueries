-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
-- List all films whose length is longer than the average length of all the films in the Sakila database.
-- Use a subquery to display all actors who appear in the film "Alone Trip".
use sakila;

-- film_id in film attaches to inventory_id in inventory which can get back the title "Hunchback Impossible"
SELECT f.film_id, i.inventory_id, f.title
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
WHERE i.inventory_id IN
	(SELECT inventory_id	
    FROM inventory
    WHERE title LIKE 'Hunchback Impossible');

SELECT COUNT(*) AS num_copies
FROM (
    SELECT i.inventory_id
    FROM inventory AS i
    JOIN film AS f ON i.film_id = f.film_id
    WHERE f.title = 'Hunchback Impossible'
) AS copies_of_hunchback;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
SELECT title, length
FROM film AS f
WHERE length > (SELECT AVG(f.length) 
				FROM film AS f);

-- Use a subquery to display all actors who appear in the film "Alone Trip"
-- actor_id in actor to pull out names, actor_id in film_actor to connect to film_id in film & film title "Alone Trip"
SELECT title
FROM film
WHERE title = 'Alone Trip';

SELECT fa.actor_id, a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id = (SELECT film_id
		FROM film
		WHERE title = 'Alone Trip');


