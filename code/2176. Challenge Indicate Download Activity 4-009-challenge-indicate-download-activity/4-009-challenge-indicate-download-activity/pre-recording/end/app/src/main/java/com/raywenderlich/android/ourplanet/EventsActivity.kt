package com.raywenderlich.android.ourplanet

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.widget.SeekBar
import com.raywenderlich.android.ourplanet.model.EOCategory
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.disposables.CompositeDisposable
import io.reactivex.rxkotlin.Observables
import io.reactivex.subjects.BehaviorSubject
import kotlinx.android.synthetic.main.activity_events.*
import java.util.*
import kotlin.math.abs

class EventsActivity : AppCompatActivity() {

  private val adapter = EventAdapter(mutableListOf())

  private val days = BehaviorSubject.createDefault(360)

  private val subscriptions = CompositeDisposable()

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

    seekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
      override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
        days.onNext(progress)
      }

      override fun onStartTrackingTouch(seekBar: SeekBar?) {}
      override fun onStopTrackingTouch(seekBar: SeekBar?) {}
    })

    val allEvents = intent.getParcelableExtra<EOCategory>(CATEGORY_KEY).events
    val eventsObservable = Observable.just(allEvents)

    subscriptions.add(
        Observables.combineLatest(days, eventsObservable) { days, events ->
          val maxInterval = (days.toLong() * 24L * 3600000L)

          events.filter { event ->
            val date = event.closeDate
            if (date != null) {
              abs(date.time - Date().time) < maxInterval
            } else {
              true
            }
          }
        }
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe {
              adapter.updateEvents(it)
            })

    subscriptions.add(days.observeOn(AndroidSchedulers.mainThread()).subscribe {
      daysTextView.text = String.format(getString(R.string.last_days_format), it)
    })
  }

  override fun onDestroy() {
    subscriptions.dispose()
    super.onDestroy()
  }
}
