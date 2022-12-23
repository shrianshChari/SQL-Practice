-- SELECT WHERE FROM (common keywords)
-- Select
-- select
-- sELECT (keywords are not case-sensitive, but all uppercase is convention)

-- SELECT * FROM table; -- End SQL statements with semicolon

-- 'strings are defined using single quotes'

CREATE DATABASE test; -- Create new database named test
SHOW DATABASES; -- view created databases
DROP DATABASE test; -- Remove a database (deletes it completely)

CREATE DATABASE record_company; -- Creates new database called record_company
USE record_company; -- Tells SQL we want to work with this database

CREATE TABLE test( -- Creates a test table
	test_column INT -- Create a column of integers
);
SHOW COLUMNS IN test; -- View the table with a single column we have created
ALTER TABLE test -- Modify an existing table
ADD another_column VARCHAR(255); -- Creates a second column that takes in strings of max length 255
SHOW COLUMNS IN test; -- View alterations to column we have made
/*
 * Note that SQL doesn't care about how many line breaks we include in a statement
 * It keeps reading in the statement it until it reaches a semicolon
 */
DROP TABLE test; -- Delete a table we have created

CREATE TABLE bands (
				id INT NOT NULL AUTO_INCREMENT, -- Commas separate statements within parentheses
				-- AUTO_INCREMENT = automatically increment as you add more bands
				name VARCHAR(255) NOT NULL,
				-- NOT NULL = row in the column MUST have a defined value
				PRIMARY KEY (id) -- Tells SQL that id is the primary identifying column
);
SHOW COLUMNS IN bands; -- Show the two columns created in bands

CREATE TABLE albums (
				id INT NOT NULL AUTO_INCREMENT,
				name VARCHAR(255) NOT NULL,
				release_year INT,
				band_id INT NOT NULL, -- We intend to connect this band_id to the id of the band table
				PRIMARY KEY (id),
				FOREIGN KEY (band_id) REFERENCES bands(id)
				/*
				 * Sets it up so that SQL will verify that a given band ID exists
				 * when creating a new table, and will also not let you delete
				 * a band in bands until you clean up its albums
				 */
);
SHOW COLUMNS IN albums; -- Show the columns created into albums

INSERT INTO bands (name) -- Inserting a value into bands
VALUES ('Iron Maiden'); -- Didn't need to specify id because it is AUTO_INCREMENT

INSERT INTO bands(name) -- Inserting multiple values into bands simultaneously
VALUES ('Deuce'), ('Avenged Sevenfold'), ('Ankor');

SELECT * FROM bands; -- Query every column from bands
SELECT * FROM bands LIMIT 2; -- Query only the first two bands
SELECT name FROM bands; -- Will only query the names in bands

SELECT id AS 'ID', name AS 'Band name' FROM bands; -- Changes the column names within query

SELECT * FROM bands, ORDER BY name; -- Queries data, orders output by the name column
SELECT * FROM bands, ORDER BY name DESC; -- Queries data, orders output by name column in descending order

INSERT INTO albums (name, release_year, band_id)
VALUES ('The Number of the Beasts', 1985, 1),
			 ('Power Slave', 1984, 1),
			 ('Nightmare', 2018, 2),
			 ('Nightmare', 2010, 3),
			 ('Test Album', NULL, 3); -- Adds several values with several columns in each entry

SELECT * FROM albums; -- Query entire albums table
SELECT name FROM albums; -- Query names from albums table
SELECT DISTINCT name FROM albums; -- Query only unique names from albums table

UPDATE albums
SET release_year = 1982
WHERE id = 1; -- Update a single value within the table

SELECT * FROM albums
WHERE release_year < 2000; -- Queries all columns of albums that came out before the year 2000

SELECT * FROM albums
WHERE name LIKE '%er%';
/*
 * Tries to match names to a given wild card
 * The "%" means "match any number of any character" (think of it as ".*" in regex)
 */

SELECT * FROM albums
WHERE name LIKE '%er%' OR band_id = 2; -- Now queries whether name has 'er' in it or it has band id of 2

SELECT * FROM albums
WHERE release_year = 1984 AND band_id = 1; -- Now queries whether album was released in 1984 and it has band id of 1

SELECT * FROM albums
WHERE release_year BETWEEN 2000 AND 2018; -- Queries albums released between 2000 and 2018 inclusive

SELECT * FROM albums
WHERE release_year IS NULL; -- Queries albums that haven't had a set release year (is NULL)

DELETE FROM albums -- Delete row from table
WHERE id = 5; -- Conditional so that we don't delete all the elements from the table

SELECT * FROM bands
JOIN albums -- Indicates we want to do a JOIN operation
ON bands.id = albums.bands_id; -- Will only join a pair of rows if the given condition is met

/*
 * Three types of JOIN operations in MySQL:
 * INNER JOIN (or just JOIN): Will only return matches
 * LEFT JOIN: Will return matches and remaining rows from left table
 * RIGHT JOIN: Will return matches and remaining rows from right table
 */

SELECT * FROM bands
INNER JOIN albums
ON bands.id = albums.bands_id; -- Same JOIN operation as before

SELECT * FROM bands
LEFT JOIN albums
ON bands.id = albums.bands_id; -- Will keep all rows from bands table

SELECT * FROM albums
RIGHT JOIN bands
ON bands.id = albums.bands_id; -- Will keep all rows from bands table (it's now on the right)
-- Mostly going to use INNER and LEFT JOINs

SELECT AVG(release_year) FROM albums;
-- Aggregate function of all the values in the column
SELECT SUM(release_year) FROM albums;
/*
 * Examples of aggregate functions:
 * AVG - average of values in column
 * SUM - sum of values in column
 * COUNT - number of values in column
 */

SELECT band_id, COUNT(band_id) FROM albums -- Gets the count of each individual band_id
GROUP BY band_id; -- And groups them by unique band_id to get the number of occurrences of each band_id

-- Pretty complicated query here
SELECT b.name AS band_name, COUNT(a.id) AS num_albums -- Renaming the columns in the output data
FROM bands AS b -- Aliasing the bands table in the query
LEFT JOIN albums AS a -- Aliasing the albums table in the query, left join includes bands that have no albums
ON b.id = a.band_id -- The JOIN condition
GROUP BY b.id; -- Group them by band

SELECT b.name AS band_name, COUNT(a.id) AS num_albums
FROM bands AS b
LEFT JOIN albums AS a
ON b.id = a.band_id
GROUP BY b.id
HAVING num_albums = 1;
-- You cannot use a WHERE in this query because WHERE will be executed before the COUNT function
-- Instead, we use HAVING in order to filter our aggregated data

