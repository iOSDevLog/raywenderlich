package com.raywenderlich.android.datadrop.ui.droplist

import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.helper.ItemTouchHelper
import android.view.View
import com.raywenderlich.android.datadrop.R
import com.raywenderlich.android.datadrop.model.Drop
import com.raywenderlich.android.datadrop.viewmodel.DropsViewModel
import kotlinx.android.synthetic.main.activity_list.*

class DropListActivity : AppCompatActivity(), DropListAdapter.DropListAdapterListener {

  private lateinit var dropsViewModel: DropsViewModel

  private val adapter = DropListAdapter(mutableListOf(), this)

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_list)

    title = getString(R.string.all_drops)

    listRecyclerView.layoutManager = LinearLayoutManager(this)
    listRecyclerView.adapter = adapter

    val itemTouchHelper = ItemTouchHelper(ItemTouchHelperCallback(adapter))
    itemTouchHelper.attachToRecyclerView(listRecyclerView)

    dropsViewModel = ViewModelProviders.of(this).get(DropsViewModel::class.java)

    dropsViewModel.getDrops().observe(this, Observer<List<Drop>> { drops ->
      adapter.updateDrops(drops ?: emptyList())
      checkForEmptyState()
    })
  }

  override fun deleteDropAtPosition(drop: Drop) {
    dropsViewModel.clearDrop(drop)
  }

  private fun checkForEmptyState() {
    emptyState.visibility = if (adapter.itemCount == 0) View.VISIBLE else View.INVISIBLE
  }

  companion object {
    fun newIntent(context: Context) = Intent(context, DropListActivity::class.java)
  }
}
