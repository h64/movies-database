-- PART 1: Basic SQL!
-- Add some movies! Add the title and synopsis of the last 5 movies you've seen that aren't already in the movies table. (If they have directors who aren't in the database, you'll have to add the directors as well!)
INSERT INTO directors (name) 
VALUES ('Chris Columbus')

INSERT INTO movies (title, synopsis, director_id) 
VALUES ('Home Alone', 'An eight-year-old troublemaker must protect his house from a pair of burglars when he is accidentally left home alone by his family during Christmas vacation.', 19)

-- As you can see, there is a column for release_date in the movies table that hasn't been filled in yet. Add the release date of your 5 favorite movies in the movies table.
UPDATE movies
SET release_date = '1990'
WHERE id = 32

-- Delete 5 movies from the list you don't like. Like them all? Add 5 movies that are total flops and then delete those suckers stuck_out_tongue_closed_eyes.
DELETE FROM movies
WHERE title = '21 Grams';

-- Add yourself as a user and create records in users_movies to record your favorites.
INSERT INTO users (name)
VALUES ('Henry');

-- PART 2: Joins!
-- Select all the movies directed by Alex Garland.
SELECT m.title, d.name as director_name
FROM movies m 
JOIN directors d
ON d.id = m.director_id
WHERE d.name = 'Alex Garland';

-- Find the director who directed "There Will Be Blood".
SELECT d.name as director_name
FROM movies m
JOIN directors d
ON d.id = m.director_id
WHERE m.title = 'There Will Be Blood';

-- Find all of J's favorites.
SELECT m.title as movie_title, u.name as user_name
FROM movies m
JOIN users_movies um ON m.id = um.movie_id 
JOIN users u on um.user_id = u.id
WHERE u.name = 'J';

-- Find everyone who added 'The Shining' as a favorite movie.
SELECT u.name
FROM users u
JOIN users_movies um ON um.user_id = u.id
JOIN movies m ON um.movie_id = m.id
WHERE m.title = 'The Shining'

-- List all the movie titles and their corresponding directors.
SELECT m.title, d.name
FROM movies m
JOIN directors d
ON m.director_id = d.id;

-- Select the movie title and user name for all of the "favorites" represented by the users_movies table.
SELECT m.title, u.name
FROM movies m
JOIN users_movies um ON m.id = um.movie_id
JOIN users u ON u.id = um.user_id;

-- PART 3: Advanced Queries!
-- These are gonna be hard. Make sure to use your friend google as a resource.

-- List the movies with the number of favorites they have.
SELECT m.title as movie_title, COUNT(um.id) as favorite_count
FROM movies m
JOIN users_movies um ON m.id = um.movie_id
GROUP BY title;

-- List the names of directors along with the number of favorites that exist for all of the movies they've made, ordered by number of favorites descending.
SELECT 
    d.name,
    m.title as movie_title, 
    COUNT(um.id) as favorite_count
FROM directors d
JOIN movies m ON m.director_id = d.id
JOIN users_movies um ON m.id = um.movie_id
GROUP BY m.title, d.name
ORDER BY favorite_count DESC;

-- List the user name, director name and favorite count of all of the user/director combinations (based on the users_movies table).
SELECT 
    u.name as user_name, 
    d.name as director_name,
    COUNT(um.id) as favorite_count
FROM directors d
JOIN movies m ON m.director_id = d.id
JOIN users_movies um ON m.id = um.movie_id
JOIN users u ON um.user_id = u.id
GROUP BY u.name, d.name
ORDER BY user_name;

-- Find the favorite director -- the director whose movies have the most favorites.
SELECT 
    d.name,
    COUNT(um.id) as favorite_count
FROM directors d
JOIN movies m ON m.director_id = d.id
JOIN users_movies um ON m.id = um.movie_id
GROUP BY d.name
ORDER BY favorite_count DESC
LIMIT 1;