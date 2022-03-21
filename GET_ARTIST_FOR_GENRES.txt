DROP FUNCTION get_artist_for_genres(integer[]);
CREATE OR REPLACE FUNCTION get_artist_for_genres(given_tag_ids INTEGER[]) 
RETURNS TABLE(
	id_result INTEGER,
	artist_result VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY SELECT DISTINCT ar.id, ar.name
	FROM SONG s INNER JOIN ARTIST ar ON s.artist_id = ar.id
	WHERE s.id IN (
		SELECT song_id 
		FROM SONG_TAGS
		WHERE genre_id = ANY(given_tag_ids)
		);
END;
$$

SELECT * FROM get_artist_for_genres (ARRAY [2, 3, 4]);
