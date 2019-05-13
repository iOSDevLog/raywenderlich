/*
 * Copyright (c) 2018 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

package com.raywenderlich.android.w00tze.ui.gists

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import com.raywenderlich.android.w00tze.R
import com.raywenderlich.android.w00tze.app.inflate
import com.raywenderlich.android.w00tze.model.Gist
import kotlinx.android.synthetic.main.list_item_gist.view.*
import java.text.SimpleDateFormat
import java.util.*


class GistAdapter(private val gists: MutableList<Gist>, private val listener: GistAdapterListener)
  : RecyclerView.Adapter<GistAdapter.ViewHolder>(), ItemTouchHelperListener {

  companion object {
    private val DATE_FORMATTER = SimpleDateFormat("EEE M/dd/yyyy hh:mm a", Locale.US)
  }

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    return ViewHolder(parent.inflate(R.layout.list_item_gist))
  }

  override fun getItemCount() = gists.size

  fun updateGists(gists: List<Gist>) {
    this.gists.clear()
    this.gists.addAll(gists)
    notifyDataSetChanged()
  }

  fun addGist(gist: Gist) {
    this.gists.add(0, gist)
    notifyItemInserted(0)
  }

  override fun onBindViewHolder(holder: ViewHolder, position: Int) {
    holder.bind(gists[position])
  }

  override fun onItemDismiss(viewHolder: RecyclerView.ViewHolder, position: Int) {
    listener.deleteGist(gists[position])
  }

  inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

    private lateinit var gist: Gist

    fun bind(gist: Gist) {
      this.gist = gist
      itemView.gistDescription.text = gist.description
      itemView.gistCreatedAt.text = DATE_FORMATTER.format(gist.createdAt)
      itemView.numFiles.text = gist.files.size.toString()
    }
  }

  interface GistAdapterListener {
    fun deleteGist(gist: Gist)
  }
}