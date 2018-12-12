package com.github.florent37.mvvmsample.search

import android.os.Bundle
import android.view.KeyEvent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions.bitmapTransform
import com.github.florent37.mvvmsample.R
import com.github.florent37.mvvmsample.omdb.Movie
import jp.wasabeef.glide.transformations.BlurTransformation
import kotlinx.android.synthetic.main.fragment_search.*

class SearchFragment : Fragment() {

    private lateinit var viewModel: SearchViewModel
    private var clickedMovie: Movie? = null
        set(value) {
            field = value
            if (value != null) {
                title.text = value.title.replace(" ", "\n").toUpperCase()
                details.text = "${value.type} (${value.year})";
                Glide.with(this)
                    .load(value.poster)
                    .apply(bitmapTransform(BlurTransformation(10, 2)))
                    .into(backgroundImage)
            }
        }

    private lateinit var adapter: MoviesAdapter;

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ) = inflater.inflate(R.layout.fragment_search, container, false)

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        adapter = MoviesAdapter()
        recyclerView.adapter = adapter
        recyclerView.layoutManager = LinearLayoutManager(context, RecyclerView.HORIZONTAL, false)

        editText.setOnKeyListener(View.OnKeyListener { _, keyCode, event ->
            if (event?.action == KeyEvent.ACTION_DOWN && keyCode == KeyEvent.KEYCODE_ENTER) {
                viewModel.search(editText.text.toString())
                return@OnKeyListener true
            }
            false
        })
        search.setOnClickListener {
            viewModel.search(editText.text.toString())
        }

        adapter.clickListener = { movie ->
            clickedMovie = movie
        }

        viewModel = ViewModelProviders.of(this).get(SearchViewModel::class.java)
        viewModel.viewState.observe(this, Observer {
            adapter.items = it.movies

            if(clickedMovie == null && it.movies.isNotEmpty()){
                clickedMovie = it.movies[0]
            }
        })
    }
}