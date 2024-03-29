CREATE OR REPLACE FUNCTION get_music_for_artists(given_artists_ids INTEGER[]) 
RETURNS TABLE(
	artist_id INTEGER,
	song_id INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
   	RETURN QUERY SELECT DISTINCT ar.id, s.id
	FROM SONG s INNER JOIN ARTIST ar ON s.artist_id = ar.id
	WHERE ar.id = ANY(given_artists_ids);
END;$$
