package com.github.florent37.mvvmsample.search

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.github.florent37.mvvmsample.R
import com.github.florent37.mvvmsample.omdb.Movie
import kotlinx.android.synthetic.main.cell_movie.view.*

class MoviesAdapter : RecyclerView.Adapter<MovieViewHolder>() {

    var clickListener: ((Movie) -> Unit)? = null

    var items = listOf<Movie>()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MovieViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.cell_movie, parent, false)
        return MovieViewHolder(view) {
            clickListener?.invoke(it)
        }
    }

    override fun getItemCount() = items.size

    override fun onBindViewHolder(holder: MovieViewHolder, position: Int) {
        holder.bind(items[position])
    }

}

class MovieViewHolder(view: View, val clickListener: (Movie) -> Unit) :
    RecyclerView.ViewHolder(view) {

    var movie: Movie? = null
    var image = view.image

    init {
        itemView.setOnClickListener {
            movie?.let(clickListener)
        }
    }

    fun bind(movie: Movie) {
        this.movie = movie

        Glide.with(image).load(movie.poster).into(image)
    }
}