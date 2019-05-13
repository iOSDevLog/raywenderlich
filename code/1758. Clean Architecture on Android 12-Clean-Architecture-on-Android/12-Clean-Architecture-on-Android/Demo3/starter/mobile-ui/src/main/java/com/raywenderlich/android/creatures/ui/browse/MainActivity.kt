package com.raywenderlich.android.creatures.ui.browse

import android.arch.lifecycle.Observer
import android.arch.lifecycle.ViewModelProviders
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.Toast
import com.raywenderlich.android.creatures.presentation.browse.BrowseCreaturesViewModel
import com.raywenderlich.android.creatures.presentation.browse.BrowseCreaturesViewModelFactory
import com.raywenderlich.android.creatures.presentation.data.Resource
import com.raywenderlich.android.creatures.presentation.data.ResourceState
import com.raywenderlich.android.creatures.presentation.model.CreatureView
import com.raywenderlich.android.creatures.ui.R
import com.raywenderlich.android.creatures.ui.mapper.CreatureMapper
import com.raywenderlich.android.creatures.ui.widget.empty.EmptyListener
import com.raywenderlich.android.creatures.ui.widget.error.ErrorListener
import dagger.android.AndroidInjection
import kotlinx.android.synthetic.main.activity_main.*
import javax.inject.Inject

class MainActivity : AppCompatActivity() {

  @Inject lateinit var creatureAdapter: CreatureAdapter
  @Inject lateinit var viewModelFactory: BrowseCreaturesViewModelFactory
  @Inject lateinit var mapper: CreatureMapper
  private lateinit var browseCreaturesViewModel: BrowseCreaturesViewModel

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)
    AndroidInjection.inject(this)

    browseCreaturesViewModel = ViewModelProviders.of(this, viewModelFactory)
        .get(BrowseCreaturesViewModel::class.java)

    setupBrowseRecycler()
    setupViewListeners()
  }

  override fun onCreateOptionsMenu(menu: Menu?): Boolean {
    menuInflater.inflate(R.menu.menu_browse, menu)
    return super.onCreateOptionsMenu(menu)
  }

  override fun onOptionsItemSelected(item: MenuItem): Boolean {
    val id = item.itemId
    when (id) {
      R.id.action_show_all_creatures -> {
        // TODO: Replace Toast
        Toast.makeText(this, "Show All clicked", Toast.LENGTH_SHORT).show()
        return true
      }
      R.id.action_show_jupiter_creatures -> {
        // TODO: Replace Toast
        Toast.makeText(this, "Show Jupiter clicked", Toast.LENGTH_SHORT).show()
        return true
      }
    }
    return super.onOptionsItemSelected(item)
  }

  override fun onStart() {
    super.onStart()
    browseCreaturesViewModel.getCreatures().observe(this,
        Observer<Resource<List<CreatureView>>> {
          if (it != null) this.handleDataState(it.status, it.data, it.message) })
  }

  private fun setupBrowseRecycler() {
    recycler_creatures.layoutManager = LinearLayoutManager(this)
    recycler_creatures.adapter = creatureAdapter
  }

  private fun handleDataState(resourceState: ResourceState, data: List<CreatureView>?,
                              message: String?) {
    when (resourceState) {
      ResourceState.LOADING -> setupScreenForLoadingState()
      ResourceState.SUCCESS -> setupScreenForSuccess(data)
      ResourceState.ERROR -> setupScreenForError(message)
    }
  }

  private fun setupScreenForLoadingState() {
    progress.visibility = View.VISIBLE
    recycler_creatures.visibility = View.GONE
    view_empty.visibility = View.GONE
    view_error.visibility = View.GONE
  }

  private fun setupScreenForSuccess(data: List<CreatureView>?) {
    view_error.visibility = View.GONE
    progress.visibility = View.GONE
    if (data!= null && data.isNotEmpty()) {
      updateListView(data)
      recycler_creatures.visibility = View.VISIBLE
    } else {
      view_empty.visibility = View.VISIBLE
    }
  }

  private fun updateListView(creatures: List<CreatureView>) {
    creatureAdapter.creatures = creatures.map { mapper.mapToViewModel(it) }
    creatureAdapter.notifyDataSetChanged()
  }

  private fun setupScreenForError(message: String?) {
    progress.visibility = View.GONE
    recycler_creatures.visibility = View.GONE
    view_empty.visibility = View.GONE
    view_error.visibility = View.VISIBLE
  }

  private fun setupViewListeners() {
    view_empty.emptyListener = emptyListener
    view_error.errorListener = errorListener
  }

  private val emptyListener = object : EmptyListener {
    override fun onCheckAgainClicked() {
      browseCreaturesViewModel.fetchCreatures()
    }
  }

  private val errorListener = object : ErrorListener {
    override fun onTryAgainClicked() {
      browseCreaturesViewModel.fetchCreatures()
    }
  }
}
