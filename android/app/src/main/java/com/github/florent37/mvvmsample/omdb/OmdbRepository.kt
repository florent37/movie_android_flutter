package com.github.florent37.mvvmsample.omdb

class OmdbRepository(val omdbApi: OMDBApi) {
    suspend fun searchMovies(byName: String): List<Movie> {
        val response = omdbApi.searchMovies(byName, OMDBApi.apiKey).await()
        return response.movies
    }
}