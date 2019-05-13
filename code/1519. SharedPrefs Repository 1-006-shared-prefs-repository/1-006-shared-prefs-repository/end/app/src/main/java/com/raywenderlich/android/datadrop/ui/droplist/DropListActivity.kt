package com.raywenderlich.android.datadrop.ui.droplist

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.helper.ItemTouchHelper
import android.view.View
import com.raywenderlich.android.datadrop.R
import com.raywenderlich.android.datadrop.app.Injection
import com.raywenderlich.android.datadrop.model.Drop
import kotlinx.android.synthetic.main.activity_list.*

class DropListActivity : AppCompatActivity(), DropListContract.View, DropListAdapter.DropListAdapterListener {

  override lateinit var presenter: DropListContract.Presenter
  private val adapter = DropListAdapter(mutableListOf(), this)

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_list)

    title = getString(R.string.all_drops)

    listRecyclerView.layoutManager = LinearLayoutManager(this)
    listRecyclerView.adapter = adapter

    val itemTouchHelper = ItemTouchHelper(ItemTouchHelperCallback(adapter))
    itemTouchHelper.attachToRecyclerView(listRecyclerView)

    presenter = Injection.provideDropListPresenter(this)
    presenter.start()
  }

  override fun showDrops(drops: List<Drop>) {
    adapter.updateDrops(drops)
    checkForEmptyState()
  }

  override fun removeDropAtPosition(position: Int) {
    adapter.removeDropAtPosition(position)
    checkForEmptyState()
  }

  override fun deleteDropAtPosition(drop: Drop, position: Int) {
    presenter.deleteDropAtPosition(drop, position)
  }

  private fun checkForEmptyState() {
    emptyState.visibility = if (adapter.itemCount == 0) View.VISIBLE else View.INVISIBLE
  }

  companion object {
    fun newIntent(context: Context) = Intent(context, DropListActivity::class.java)
  }
}
