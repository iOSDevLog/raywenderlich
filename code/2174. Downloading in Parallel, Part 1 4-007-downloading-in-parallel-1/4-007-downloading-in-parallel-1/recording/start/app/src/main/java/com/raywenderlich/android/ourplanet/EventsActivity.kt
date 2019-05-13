package com.raywenderlich.android.ourplanet

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import com.raywenderlich.android.ourplanet.model.EOCategory
import kotlinx.android.synthetic.main.activity_events.*

class EventsActivity : AppCompatActivity() {

  private val adapter = EventAdapter(mutableListOf())

  companion object {
    private const val CATEGORY_KEY = "CATEGORY_KEY"

    fun newIntent(context: Context, category: EOCategory): Intent {
      val intent = Intent(context, EventsActivity::class.java)
      intent.putExtra(CATEGORY_KEY, category)
      return intent
    }
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_events)

    supportActionBar?.setDisplayHomeAsUpEnabled(true)

    title = intent.getParcelableExtra<EOCategory>(CATEGORY_KEY).title

    eventsRecyclerView.layoutManager = LinearLayoutManager(this)
    eventsRecyclerView.adapter = adapter

    adapter.updateEvents(intent.getParcelableExtra<EOCategory>(CATEGORY_KEY).events)
  }
}
