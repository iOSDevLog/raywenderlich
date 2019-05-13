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

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.view.inputmethod.EditorInfo
import android.widget.TextView
import android.widget.Toast
import com.raywenderlich.android.octomembers.R
import com.raywenderlich.android.octomembers.ui.extensions.hideKeyboard
import com.raywenderlich.android.octomembers.model.Member
import com.raywenderlich.android.octomembers.repository.remote.RemoteRepository
import kotlinx.android.synthetic.main.activity_team_members.*


class TeamMembersActivity : AppCompatActivity(), TeamMembersContract.View {

  lateinit var presenter: TeamMembersContract.Presenter
  lateinit var adapter: TeamMemberAdapter

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_team_members)

    setupPresenter()
    setupEditText()
    setupShowMembersButton()
    setupRecyclerView()
  }

  private fun setupPresenter() {
    presenter = TeamMembersPresenter(RemoteRepository(), this)
  }

  private fun setupEditText() {
    teamName.setSelection(teamName.text.length)
    teamName.setOnEditorActionListener(TextView.OnEditorActionListener { _, actionId, _ ->
      if (actionId == EditorInfo.IME_ACTION_DONE) {
        showMembers.performClick()
        return@OnEditorActionListener true
      }
      false
    })
  }

  private fun setupShowMembersButton() {
    showMembers.setOnClickListener {
      val teamNameValue = teamName.text.toString()
      if (teamNameValue.isNotEmpty()) {
        presenter.retrieveAllMembers(teamNameValue)
      } else {
        showTeamNameEmptyError()
      }
    }
  }

  private fun setupRecyclerView() {
    teamMembersList.layoutManager = LinearLayoutManager(this)
    adapter = TeamMemberAdapter(listOf())
    teamMembersList.adapter = adapter
  }

  private fun showTeamNameEmptyError() {
    Toast.makeText(this, getString(R.string.error_team_name_empty), Toast.LENGTH_SHORT).show()
  }

  override fun showMembers(members: List<Member>) {
    teamMembersList.hideKeyboard()
    adapter.members = members
    adapter.notifyDataSetChanged()
  }

  override fun showErrorRetrievingMembers() {
    Toast.makeText(this, getString(R.string.error_retrieving_team), Toast.LENGTH_SHORT).show()
  }

  override fun clearMembers() {
    adapter.members = listOf()
    adapter.notifyDataSetChanged()
  }
}
