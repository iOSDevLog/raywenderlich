package com.raywenderlich.android.gitfeed

import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {

  private lateinit var viewModel: MainViewModel

  private val adapter = EventAdapter(mutableListOf())

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)

    recyclerView.layoutManager = LinearLayoutManager(this)
    recyclerView.adapter = adapter

    swipeContainer.setOnRefreshListener {
      adapter.clear()
      viewModel.fetchEvents()
    }

    viewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)

    viewModel.eventLiveData.observe(this, Observer { events ->
      adapter.updateEvents(events)
      swipeContainer.isRefreshing = false
    })

    viewModel.fetchEvents()
  }
}
