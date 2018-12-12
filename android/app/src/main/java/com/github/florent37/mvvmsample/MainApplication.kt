package com.github.florent37.mvvmsample

import android.app.Application
import com.github.florent37.mvvmsample.omdb.OMDBApi
import com.github.florent37.mvvmsample.omdb.OmdbRepository
import com.jakewharton.retrofit2.adapter.kotlin.coroutines.CoroutineCallAdapterFactory
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

lateinit var mainApplication: MainApplication

class MainApplication : Application() {
    val api by lazy {
        Retrofit.Builder()
            .baseUrl(OMDBApi.baseUrl)
            .client(
                OkHttpClient.Builder()
                    .addInterceptor(HttpLoggingInterceptor().setLevel(HttpLoggingInterceptor.Level.BASIC))
                    .build()
            )
            .addConverterFactory(GsonConverterFactory.create())
            .addCallAdapterFactory(CoroutineCallAdapterFactory())
            .build()
            .create(OMDBApi::class.java)
    }

    val omdbRepository by lazy {
        OmdbRepository(api)
    }

    override fun onCreate() {
        super.onCreate()
        mainApplication = this
    }


}