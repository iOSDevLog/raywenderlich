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

import android.content.Context
import android.graphics.BitmapFactory
import android.graphics.Color
import android.support.v4.content.ContextCompat
import android.support.v7.graphics.Palette
import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.view.animation.AnimationUtils
import com.raywenderlich.android.creatures.R
import com.raywenderlich.android.creatures.app.Constants
import com.raywenderlich.android.creatures.app.inflate
import com.raywenderlich.android.creatures.model.Creature
import kotlinx.android.synthetic.main.list_item_creature_card_jupiter.view.*

class CreatureCardAdapter(private val creatures: MutableList<Creature>) : RecyclerView.Adapter<CreatureCardAdapter.ViewHolder>() {

  var scrollDirection = ScrollDirection.DOWN
  var jupiterSpanSize = 2

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    return when (viewType) {
      ViewType.OTHER.ordinal -> ViewHolder(parent.inflate(R.layout.list_item_creature_card))
      ViewType.MARS.ordinal -> ViewHolder(parent.inflate(R.layout.list_item_creature_card_mars))
      ViewType.JUPITER.ordinal -> ViewHolder(parent.inflate(R.layout.list_item_creature_card_jupiter))
      else -> throw IllegalArgumentException("Illegal value for viewType")
    }
  }

  override fun onBindViewHolder(holder: CreatureCardAdapter.ViewHolder, position: Int) {
    holder.bind(creatures[position])
  }

  override fun getItemCount() = creatures.size

  override fun getItemViewType(position: Int) =
    when (creatures[position].planet) {
      Constants.JUPITER -> ViewType.JUPITER.ordinal
      Constants.MARS -> ViewType.MARS.ordinal
      else -> ViewType.OTHER.ordinal
    }

  fun spanSizeAtPosition(position: Int): Int {
    return if (creatures[position].planet == Constants.JUPITER) {
      jupiterSpanSize
    } else {
      1
    }
  }

  inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {

    private lateinit var creature: Creature

    init {
      itemView.setOnClickListener(this)
    }

    fun bind(creature: Creature) {
      this.creature = creature
      val context = itemView.context
      val imageResource = context.resources.getIdentifier(creature.thumbnail, null, context.packageName)
      itemView.creatureImage.setImageResource(imageResource)
      itemView.fullName.text = creature.fullName
      setBackgroundColors(context, imageResource)
      animateView(itemView)
    }

    override fun onClick(view: View) {
      val context = view.context
      val intent = CreatureActivity.newIntent(context, creature.id)
      context.startActivity(intent)
    }

    private fun setBackgroundColors(context: Context, imageResource: Int) {
      val image = BitmapFactory.decodeResource(context.resources, imageResource)
      Palette.from(image).generate { palette ->
        val backgroundColor = palette.getDominantColor(ContextCompat.getColor(context, R.color.colorPrimaryDark))
        itemView.creatureCard.setBackgroundColor(backgroundColor)
        itemView.nameHolder.setBackgroundColor(backgroundColor)
        val textColor = if (isColorDark(backgroundColor)) Color.WHITE else Color.BLACK
        itemView.fullName.setTextColor(textColor)
        if (itemView.slogan != null) {
          itemView.slogan.setTextColor(textColor)
        }
      }
    }

    private fun isColorDark(color: Int): Boolean {
      val darkness = 1 - (0.299 * Color.red(color) + 0.587 * Color.green(color) + 0.114 * Color.blue(color)) / 255
      return darkness >= 0.5
    }

    private fun animateView(viewToAnimate: View) {
      if (viewToAnimate.animation == null) {
        val animation = AnimationUtils.loadAnimation(viewToAnimate.context, R.anim.scale_xy)
        viewToAnimate.animation = animation
      }
    }
  }

  enum class ScrollDirection {
    UP, DOWN
  }

  enum class ViewType {
    JUPITER, MARS, OTHER
  }
}