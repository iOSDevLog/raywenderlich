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

package com.raywenderlich.android.foodmart.ui.items

import android.animation.ValueAnimator
import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import com.airbnb.lottie.LottieAnimationView
import com.raywenderlich.android.foodmart.R
import com.raywenderlich.android.foodmart.app.inflate
import com.raywenderlich.android.foodmart.model.Food
import kotlinx.android.synthetic.main.list_item_food.view.*




class ItemsAdapter(private val items: MutableList<Food>, private val listener: ItemsAdapterListener) : RecyclerView.Adapter<ItemsAdapter.ViewHolder>() {

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) =
    ViewHolder(parent.inflate(R.layout.list_item_food))

  override fun onBindViewHolder(holder: ItemsAdapter.ViewHolder, position: Int) {
    holder.bind(items[position])
  }

  override fun getItemCount() = items.size

  fun updateItems(items: List<Food>) {
    this.items.clear()
    this.items.addAll(items)
    notifyDataSetChanged()
  }

  inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {

    private lateinit var item: Food

    init {
      itemView.setOnClickListener(this)
    }

    fun bind(item: Food) {
      this.item = item
      val context = itemView.context
      itemView.foodImage.setImageResource(context.resources.getIdentifier(item.thumbnail, null, context.packageName))
      itemView.name.text = item.name
      itemView.cartButton.setImageResource(if (item.isInCart) R.drawable.ic_done else R.drawable.ic_add)
      itemView.cartButton.setOnClickListener {
        if (item.isInCart) {
          listener.removeItem(item, itemView.cartButton)
        } else {
          listener.addItem(item, itemView.foodImage, itemView.cartButton)
        }
      }
      itemView.faveButton.progress = if (item.isFavorite) 1f else 0f
      itemView.faveButton.setOnClickListener {
        if (item.isFavorite) {
          listener.removeFavorite(item)
          playReverseFavoriteAnimation(itemView.faveButton)
        } else {
          listener.addFavorite(item)
          itemView.faveButton.playAnimation()
        }
      }
    }

    private fun playReverseFavoriteAnimation(animationView: LottieAnimationView) {
      val progress = 0.5f
      val valueAnimator = ValueAnimator.ofFloat(-progress, 0f).setDuration((animationView.duration * progress).toLong())
      valueAnimator.addUpdateListener { animation -> animationView.progress = Math.abs(animation.animatedValue as Float) }
      valueAnimator.start()
    }

    override fun onClick(view: View) {
      listener.showFoodDetail(view, item)
    }
  }

  interface ItemsAdapterListener {
    fun removeItem(item: Food, cartButton: ImageView)
    fun addItem(item: Food, foodImageView: ImageView, cartButton: ImageView)
    fun showFoodDetail(view: View, food: Food)
    fun removeFavorite(item: Food)
    fun addFavorite(item: Food)
  }
}