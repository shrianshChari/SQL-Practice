-- Exercise 1
CREATE TABLE songs (
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	length FLOAT NOT NULL,
	album_id INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (album_id) REFERENCES albums(id)
);

-- Exercise 2
SELECT name AS 'Band Name' FROM bands;

-- Exercise 3
SELECT * FROM albums
WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;

-- Exercise 4
SELECT bands.name as 'Band Name'
FROM bands LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) > 0;

-- Exercise 5
SELECT bands.name as 'Band Name'
FROM bands LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY bands.id
HAVING COUNT(albums.id) = 0;

-- Exercise 6
SELECT albums.name AS 'Name', albums.release_year AS 'Release Year', SUM(songs.length) AS 'Duration'
FROM albums LEFT JOIN songs ON albums.id = songs.album_id
GROUP BY albums.id
ORDER BY SUM(songs.length) DESC
LIMIT 1; 

-- Exercise 7
UPDATE albums
SET release_year = 1986
WHERE release_year IS NULL;

-- Exercise 8
INSERT INTO bands (id, name)
VALUES (8, 'AC/DC');

INSERT INTO albums (name, release_year, band_id)
VALUES ('Back in Black', 1980, 8); -- Grabbed from Wikipedia lol

-- Exercise 9
DELETE FROM albums
WHERE band_id = 8;

DELETE FROM bands
WHERE id = 8;

-- Exercise 10
SELECT AVG(length) as 'Average Song Duration' FROM songs;

-- Exercise 11
SELECT albums.name AS 'Name', albums.release_year AS 'Release Year', MAX(songs.length) AS 'Duration'
FROM albums JOIN songs ON albums.id = songs.album_id
GROUP BY albums.id;

-- Exercise 12
SELECT albums.id AS 'ID', albums.name AS 'Name', albums.release_year AS 'Release Year', COUNT(songs.length) AS 'Number of Songs'
FROM albums JOIN songs ON albums.id = songs.album_id
GROUP BY albums.id;

-- Exercise 13
SELECT bands.name AS 'Band', COUNT(albums.length) AS 'Number of Songs'
FROM bands
JOIN albums ON bands.id = albums.band_id
JOIN songs ON albums.id = songs.album_id
GROUP BY bands.id;

-- Or, if you want to see even the bands that have no albums
SELECT bands.name AS 'Band', COUNT(albums.length) AS 'Number of Songs'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
LEFT JOIN songs ON albums.id = songs.album_id
GROUP BY bands.id;

