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

package com.raywenderlich.android.octomembers.ui.teammembers

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.raywenderlich.android.octomembers.R
import com.raywenderlich.android.octomembers.model.Member
import com.raywenderlich.android.octomembers.ui.member.MemberActivity
import kotlinx.android.synthetic.main.list_item_team_member.view.*

class TeamMemberAdapter(var members: List<Member>) : RecyclerView.Adapter<TeamMemberAdapter.TeamMemberViewHolder>() {

  override fun onBindViewHolder(holder: TeamMemberViewHolder, position: Int) = holder.bind(members[position])

  override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TeamMemberViewHolder {
    val itemView = LayoutInflater.from(parent.context).inflate(R.layout.list_item_team_member, parent, false)
    return TeamMemberViewHolder(itemView)
  }

  override fun getItemCount() = members.size

  inner class TeamMemberViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {

    lateinit var member: Member

    init {
      itemView.setOnClickListener(this)
    }

    fun bind(member: Member) {
      this.member = member
      itemView.teamMemberLogin.text = member.login
    }

    override fun onClick(view: View) {
      val context = view.context
      val intent = MemberActivity.newIntent(context, member.login)
      context.startActivity(intent)
    }
  }
}