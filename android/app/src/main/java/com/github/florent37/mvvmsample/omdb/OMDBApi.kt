package com.github.florent37.mvvmsample.omdb

import kotlinx.coroutines.Deferred
import retrofit2.http.GET
import retrofit2.http.Query

interface OMDBApi {
    @GET("/")
    fun searchMovies(@Query("s") name: String, @Query("apiKey") apikey: String) : Deferred<SearchResponse>

    companion object {
        val apiKey = "86850a46"
        val baseUrl = "https://www.omdbapi.com/"
    }
}