DROP TABLE IF EXISTS TF_IDF_VIEW;
CREATE TABLE TF_IDF_VIEW(
	id INTEGER,
	artist_name TEXT,
	tag_name TEXT
);

ALTER TABLE TF_IDF_VIEW ADD COLUMN search_vector tsvector;
CREATE INDEX ix_search_vector ON TF_IDF_VIEW USING GIN (search_vector);

CREATE OR REPLACE FUNCTION update_song_content() RETURNS trigger AS $$
BEGIN
	IF (new.tag_name IS NULL) THEN
        new.tag_name := '';
    END IF;
	
    new.search_vector := setweight(to_tsvector(coalesce(new.artist_name, '')), 'A') ||
        setweight(to_tsvector(coalesce(new.tag_name, '')), 'B');
    return new;
END
$$ LANGUAGE plpgsql;

CREATE TRIGGER song_search_vector_update BEFORE INSERT OR UPDATE
ON TF_IDF_VIEW
FOR EACH ROW EXECUTE PROCEDURE update_song_content();

INSERT INTO TF_IDF_VIEW
	SELECT s.id AS id, ar.name, s.tag 
	FROM song s INNER JOIN artist ar ON s.artist_id = ar.id;

select * from TF_IDF_VIEW;


SELECT id, artist_name, ts_rank(search_vector, websearch_to_tsquery('rihanna')) as rank
FROM TF_IDF_VIEW
ORDER BY rank DESC;


