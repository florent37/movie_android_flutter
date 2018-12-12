package com.github.florent37.mvvmsample.omdb

import com.google.gson.annotations.SerializedName

class SearchResponse {
    @SerializedName("Search")
    var movies: List<Movie> = listOf()
}
