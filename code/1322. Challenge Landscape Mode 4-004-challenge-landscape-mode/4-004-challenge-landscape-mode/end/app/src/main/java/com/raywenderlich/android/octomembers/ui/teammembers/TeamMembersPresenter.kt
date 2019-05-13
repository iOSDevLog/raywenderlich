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

import com.raywenderlich.android.octomembers.model.Member
import com.raywenderlich.android.octomembers.repository.Repository
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class TeamMembersPresenter(val repository: Repository, val view: TeamMembersContract.View) : TeamMembersContract.Presenter {

  override fun retrieveAllMembers(teamName: String) {
    showViewLoadingState()
    repository.retrieveTeamMembers(teamName, object : Callback<List<Member>> {
      override fun onResponse(call: Call<List<Member>>?, response: Response<List<Member>>?) {
        val members = response?.body()
        if (members != null) {
          showMembersAndEnableInput(members)
        } else {
          clearViewMembersAndShowError()
          enableInput()
        }
      }

      override fun onFailure(call: Call<List<Member>>?, t: Throwable?) {
        clearViewMembersAndShowError()
        enableInput()
      }
    })
  }

  private fun clearViewMembersAndShowError() {
    view.clearMembers()
    view.showErrorRetrievingMembers()
    view.hideLoading()
  }

  private fun showViewLoadingState() {
    view.showLoading()
    view.disableInput()
    view.hideMembers()
    view.hideEmptyState()
  }

  private fun showMembersAndEnableInput(members: List<Member>) {
    if (members.isNotEmpty()) {
      showMembersInView(members)
    } else {
      showEmptyState()
    }
    enableInput()
  }

  private fun showMembersInView(members: List<Member>) {
    view.showMembers(members)
    view.hideLoading()
  }

  private fun showEmptyState() {
    view.showEmptyState()
    view.hideMembers()
    view.hideLoading()
  }

  private fun enableInput() {
    view.enableInput()
  }
}