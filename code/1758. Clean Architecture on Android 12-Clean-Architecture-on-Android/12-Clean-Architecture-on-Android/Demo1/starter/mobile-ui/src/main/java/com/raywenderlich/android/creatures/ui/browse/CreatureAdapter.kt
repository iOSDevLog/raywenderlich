package com.raywenderlich.android.creatures.ui.browse

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import com.bumptech.glide.Glide
import com.bumptech.glide.request.RequestOptions
import com.raywenderlich.android.creatures.ui.R
import com.raywenderlich.android.creatures.ui.model.CreatureViewModel
import javax.inject.Inject


class CreatureAdapter @Inject constructor(): RecyclerView.Adapter<CreatureAdapter.ViewHolder>() {

  var creatures: List<CreatureViewModel> = arrayListOf()

  override fun onBindViewHolder(holder: ViewHolder, position: Int) {
    val creature = creatures[position]
    holder.nameText.text = creature.fullName
    holder.titleText.text = creature.planet

    Glide.with(holder.itemView.context)
        .load(creature.image)
        .apply(RequestOptions.circleCropTransform())
        .into(holder.avatarImage)
  }

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
    val itemView = LayoutInflater
        .from(parent.context)
        .inflate(R.layout.item_creature, parent, false)
    return ViewHolder(itemView)
  }

  override fun getItemCount(): Int {
    return creatures.size
  }

  inner class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
    var avatarImage: ImageView = view.findViewById(R.id.image_avatar)
    var nameText: TextView = view.findViewById(R.id.text_name)
    var titleText: TextView = view.findViewById(R.id.text_title)
  }
}