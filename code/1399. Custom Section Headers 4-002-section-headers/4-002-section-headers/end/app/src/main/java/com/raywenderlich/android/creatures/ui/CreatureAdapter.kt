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
 */

package com.raywenderlich.android.creatures.ui

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import com.raywenderlich.android.creatures.R
import com.raywenderlich.android.creatures.app.inflate
import com.raywenderlich.android.creatures.model.Creature
import com.raywenderlich.android.creatures.model.CompositeItem
import kotlinx.android.synthetic.main.list_item_creature.view.*
import kotlinx.android.synthetic.main.list_item_planet_header.view.*


class CreatureAdapter(private val compositeItems: MutableList<CompositeItem>) : RecyclerView.Adapter<CreatureAdapter.ViewHolder>() {

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    return when(viewType) {
      ViewType.HEADER.ordinal -> ViewHolder(parent.inflate(R.layout.list_item_planet_header))
      ViewType.CREATURE.ordinal -> ViewHolder(parent.inflate(R.layout.list_item_creature))
      else -> throw IllegalArgumentException("Illegal value for viewType")
    }
  }

  override fun onBindViewHolder(holder: CreatureAdapter.ViewHolder, position: Int) {
    holder.bind(compositeItems[position])
  }

  override fun getItemCount() = compositeItems.size

  override fun getItemViewType(position: Int): Int {
    return if (compositeItems[position].isHeader) {
      ViewType.HEADER.ordinal
    } else {
      ViewType.CREATURE.ordinal
    }
  }

  fun updateCreatures(compositeItems: List<CompositeItem>) {
    this.compositeItems.clear()
    this.compositeItems.addAll(compositeItems)
    notifyDataSetChanged()
  }

  class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {

    private lateinit var creature: Creature

    init {
      itemView.setOnClickListener(this)
    }

    fun bind(compositeItem: CompositeItem) {
      if (compositeItem.isHeader) {
        itemView.headerName.text = compositeItem.header.name
      } else {
        creature = compositeItem.creature
        val context = itemView.context
        itemView.creatureImage.setImageResource(context.resources.getIdentifier(creature.thumbnail, null, context.packageName))
        itemView.fullName.text = creature.fullName
        itemView.nickname.text = creature.nickname
        animateView(itemView)
      }
    }

    override fun onClick(view: View) {
      val context = view.context
      val intent = CreatureActivity.newIntent(context, creature.id)
      context.startActivity(intent)
    }

    private fun animateView(viewToAnimate: View) {
      if (viewToAnimate.animation == null) {
        val animation = AnimationUtils.loadAnimation(viewToAnimate.context, R.anim.scale_xy)
        viewToAnimate.animation = animation
      }
    }
  }

  enum class ViewType {
    HEADER, CREATURE
  }
}