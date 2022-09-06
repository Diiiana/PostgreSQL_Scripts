CREATE MATERIALIZED VIEW content_based_powers_and_tf AS

SELECT s.id AS id, s.danceability AS danceability, s.speechiness AS speechiness, s.acousticness AS acousticness, 
s.instrumentalness AS instrumentalness, s.valence AS valence, s.energy AS energy, ar.name AS artist_name, s.tag, s.image,
COALESCE(NULLIF((POWER(s.danceability, 2) + POWER(s.speechiness, 2) + POWER(s.acousticness, 2) 
				+ POWER(s.instrumentalness, 2) + POWER(s.valence, 2) + POWER(s.energy, 2)), 0), 1) AS sum_of_squares,
				spotify_uri
FROM song s INNER JOIN artist ar ON s.artist_id = ar.id;


