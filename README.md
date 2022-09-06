# PostgreSQL_Scripts

Scripts used for comparing two songs at lowest level, database level.

CONTENT_BASED_RECOMMENDATIONS_PGSQL 
&nbsp;&nbsp;&nbsp; > stored procedure that compares two songs based on their attributes

GET_ARTIST_FOR_GENRES
&nbsp;&nbsp;&nbsp; > function that retrieves artists based on the selected genres

GET_MUSIC_FOR_ARTISTS
&nbsp;&nbsp;&nbsp; > function that retrieves songs associated with a mentioned artist names

SONG_COSINE_VIEW_WITH_SQUARES
&nbsp;&nbsp;&nbsp; > materialized view for fast access to precalculated information used in content-based similarity

TF_IDF_POSTGRESQL
&nbsp;&nbsp;&nbsp; > fast implementation for TF-IDF method, using indexes and ranking

*Mentioned scripts were used for the implementation of the music recommender system:
https://github.com/Diiiana/MusicRecommenderSystem_backend

