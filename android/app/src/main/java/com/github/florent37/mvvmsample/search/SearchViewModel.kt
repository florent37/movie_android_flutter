package com.github.florent37.mvvmsample.search

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.github.florent37.mvvmsample.mainApplication
import kotlinx.coroutines.*
import kotlin.coroutines.CoroutineContext

class SearchViewModel(application: Application) : AndroidViewModel(application), CoroutineScope {
    private val job = Job()
    override val coroutineContext: CoroutineContext
        get() = job + Dispatchers.Main

    private val mutableViewState = MutableLiveData<SearchViewState>()
    val viewState : LiveData<SearchViewState> = mutableViewState

    private val repository by lazy {
        mainApplication.omdbRepository
    }

    init {
        start()
    }

    private fun start(){
        search("avengers")
    }

    fun search(name : String) {
        launch {
            val movies = repository.searchMovies(name)
            mutableViewState.postValue(SearchViewState(movies))
        }

    }
}