package com.github.florent37.mvvmsample.omdb

import com.google.gson.annotations.SerializedName

class Movie {
    @SerializedName("Title")
    var title : String = ""
    @SerializedName("Year")
    var year : String = ""
    @SerializedName("ImdbID")
    var imdbID : String = ""
    @SerializedName("Type")
    var type : String = ""
    @SerializedName("Poster")
    var poster : String = ""
}