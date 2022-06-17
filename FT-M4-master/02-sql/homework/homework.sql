--  1. Birthyear
​
SELECT * FROM movies
WHERE year=2000;
​
-- 2. 1982
​
SELECT COUNT(*) AS total FROM movies
WHERE year=1982;
​
-- 3. Stacktors
​
SELECT * FROM actors
WHERE last_name = '%stack%';
​
-- 4. Fame Name Game
SELECT first_name, last_name, COUNT(*) AS total 
FROM actors
GROUP BY LOWER(first_name), LOWER(last_name)
ORDER BY total DESC
LIMIT 10;
​
-- 5. Prolific
SELECT id, first_name, last_name, COUNT(*) AS total_roles
FROM actors
JOIN roles ON actors.id = roles.actor_id
GROUP BY actor_id
ORDER BY total_roles DESC
LIMIT 100;
​
-- 6. Bottom of the Barrel
SELECT genre, COUNT(*) AS total
FROM movies_genres
GROUP BY genre
ORDER BY total;
​
-- 7. Braveheart
​
SELECT first_name, last_name
FROM actors
JOIN roles ON actors.id = roles.actor_id
JOIN movies ON roles.movie_id = movies.id
WHERE movies.name = 'Braveheart' AND movies.year = 1995
ORDER BY last_name;

​
-- 8. Leap Noir
-- directors            nombre y apellido del director
-- movies_directors
-- movies               nombre y año
-- movies_genres
​
SELECT d.first_name, d.last_name, m.name, m.year
FROM directors AS d
JOIN movies_directors AS md ON d.id = md.director_id
JOIN movies AS m ON md.movie_id = m.id
JOIN movies_genres AS mg ON m.id = mg.movie_id
WHERE mg.genre = 'Film-Noir' AND m.year % 4 = 0
ORDER BY m.name;
​
-- 9. Bacon
​
--  actors          nombre y apellido
--  roles
--  movies          name
--  movies_genres
​
SELECT a.first_name, a.last_name, m.name AS movie
FROM actors AS a
JOIN roles ON a.id = roles.actor_id
JOIN movies AS m ON roles.movie_id = m.id
JOIN movies_genres ON m.id = movies_genres.movie_id
WHERE movies_genres.genre = 'Drama' AND m.id IN (
    SELECT roles.movie_id
    FROM roles
    JOIN actors ON roles.actor_id = actors.id
    WHERE actors.first_name = 'Kevin' AND actors.last_name = 'Bacon'
)
AND (a.first_name || a.last_name != 'KevinBacon');
​
-- 10. Immortal Actors
-- actors
-- roles
-- movies
​
SELECT first_name, last_name
FROM actors
WHERE id IN (
    SELECT roles.actor_id
    FROM roles 
    JOIN movies ON movies.id = roles.movie_id
    WHERE year < 1900
) AND id IN (
    SELECT roles.actor_id
    FROM roles 
    JOIN movies ON movies.id = roles.movie_id
    WHERE year > 2000
);
​
​
-- 11. Busy Filming
​
-- actors       first_name y last_name
-- roles        COUNT
-- movies       name
​
SELECT a.first_name, a.last_name, m.name AS movie, COUNT(DISTINCT(role)) AS total_roles
FROM actors AS a
JOIN roles AS r ON a.id = r.actor_id
JOIN movies AS m ON r.movie_id = m.id
WHERE m.year > 1990
GROUP BY a.id, m.id
HAVING total_roles >= 5;
​
-- 12. Mujeres
​
SELECT year, COUNT(DISTINCT id) AS total
FROM movies
WHERE id NOT IN(
    SELECT movie_id
    FROM roles 
    JOIN actors ON roles.actor_id = actors.id
    WHERE actors.gender = 'M'
)
GROUP BY year;
​
