
DROP FUNCTION song_similarities(integer);
CREATE OR REPLACE FUNCTION song_similarities(song_id INTEGER) RETURNS TABLE (
	id INTEGER,
	artist VARCHAR(200),
	tag TEXT,
	spotify_uri TEXT,
	image BYTEA
) AS $$
	DECLARE for_song content_based_powers_and_tf;
	DECLARE record content_based_powers_and_tf;
	
	DECLARE counter INTEGER := 0;
	DECLARE R FLOAT;
	
	DECLARE Numarator FLOAT;
	DECLARE Numitor FLOAT;
	
	DECLARE B_numitor FLOAT;
	DECLARE A_numitor FLOAT;
	
	DECLARE song_text TEXT;

	BEGIN
	
	-- local table with all songs
	DROP TABLE IF EXISTS temp_songs;
	CREATE TEMP TABLE IF NOT EXISTS temp_songs AS
		SELECT * 
		FROM content_based_powers_and_tf;
	
	-- search for given song
	SELECT * INTO for_song
		FROM temp_songs
		WHERE temp_songs.id = song_id;
	
	DELETE FROM temp_songs t WHERE t.id = song_id;
	
	DROP TABLE IF EXISTS recommendations;
	CREATE TEMP TABLE recommendations(
		sim_float FLOAT,
		id INTEGER,
		artist VARCHAR(200),
		tag TEXT,
		spotify_uri TEXT,
		image BYTEA
	);
	
	DROP TABLE IF EXISTS recommendations_tf_idf;
	CREATE TEMP TABLE recommendations_tf_idf(
		id INTEGER,
		tag_name TEXT,
		rank_v REAL
	);
	for record in (select * from temp_songs) loop 

		-- dot product
		SELECT for_song.danceability * record.danceability + for_song.speechiness * record.speechiness + for_song.acousticness * record.acousticness 
		+ for_song.instrumentalness * record.instrumentalness + for_song.valence * record.valence + for_song.energy * record.energy
		INTO Numarator;
		
		-- sums of square values
		SELECT for_song.sum_of_squares
		INTO A_numitor;
		
		SELECT record.sum_of_squares
		INTO B_Numitor;

		SELECT Numarator / (sqrt(A_numitor) * sqrt(B_Numitor)) INTO R;
		
		INSERT INTO recommendations
		VALUES(R, record.id, record.artist_name, record.tag, record.spotify_uri, record.image);

		counter = counter + 1;
	end loop; 
	
	SELECT CONCAT(for_song.artist_name, ' ', for_song.tag) INTO song_text;
	
	INSERT INTO recommendations_tf_idf 
	SELECT t.id, t.tag_name, ts_rank(search_vector, websearch_to_tsquery(song_text)) as rank_v
	FROM TF_IDF_VIEW t;
	
	RETURN QUERY
	SELECT r.id, r.artist, r.tag, r.spotify_uri, r.image
	FROM recommendations r INNER JOIN recommendations_tf_idf t ON r.id = t.id
	ORDER BY t.rank_v DESC, r.sim_float DESC
	LIMIT 20;
	
	END
$$
LANGUAGE plpgsql;

SELECT * FROM song_similarities(49725) 
