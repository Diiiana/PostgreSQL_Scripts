# PostgreSQL_Scripts

Scripts used for comparing two songs at lowest level, database level.

CONTENT_BASED_RECOMMENDATIONS_PGSQL <br/>
&nbsp;&nbsp;&nbsp; > _stored procedure that compares two songs based on their attributes_

GET_ARTIST_FOR_GENRES <br/>
&nbsp;&nbsp;&nbsp; > _function that retrieves artists based on the selected genres_

GET_MUSIC_FOR_ARTISTS <br/>
&nbsp;&nbsp;&nbsp; > _function that retrieves songs associated with a mentioned artist names_

SONG_COSINE_VIEW_WITH_SQUARES <br/>
&nbsp;&nbsp;&nbsp; > _materialized view for fast access to precalculated information used in content-based similarity_

TF_IDF_POSTGRESQL <br/>
&nbsp;&nbsp;&nbsp; > _fast implementation for TF-IDF method, using indexes and ranking_

<br/>

_Mentioned scripts were used for the implementation of the music recommender system:_
https://github.com/Diiiana/MusicRecommenderSystem_backend

