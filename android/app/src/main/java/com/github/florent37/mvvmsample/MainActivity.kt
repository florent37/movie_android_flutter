package com.github.florent37.mvvmsample

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.github.florent37.mvvmsample.search.SearchFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        supportFragmentManager.beginTransaction()
            .replace(R.id.container, SearchFragment())
            .commitAllowingStateLoss()
    }
}
