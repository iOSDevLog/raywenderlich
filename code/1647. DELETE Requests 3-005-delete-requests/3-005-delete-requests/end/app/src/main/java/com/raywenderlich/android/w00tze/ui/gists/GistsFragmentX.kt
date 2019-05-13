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

import android.support.v7.app.AlertDialog
import android.text.Editable
import android.text.TextWatcher
import android.widget.EditText
import com.raywenderlich.android.w00tze.R
import kotlinx.android.synthetic.main.fragment_gists.*


internal fun GistsFragment.showGistDialog() {
  val dialogBuilder = AlertDialog.Builder(gistsRecyclerView.context)
  val dialogView = this.layoutInflater.inflate(R.layout.dialog_gist, null)
  dialogBuilder.setView(dialogView)

  val description = dialogView.findViewById(R.id.descriptionEditText) as EditText
  val filename = dialogView.findViewById(R.id.filenameEditText) as EditText
  val content = dialogView.findViewById(R.id.contentEditText) as EditText

  dialogBuilder.setTitle(getString(R.string.new_gist))
  dialogBuilder.setPositiveButton(getString(R.string.make_gist), { _, _ ->
    sendGist(description.text.toString(), filename.text.toString(), content.text.toString())
  })
  dialogBuilder.setNegativeButton(getString(R.string.cancel), { _, _ ->
    //pass
  })

  val dialog = dialogBuilder.create()

  dialog.setOnShowListener {
    dialog.getButton(AlertDialog.BUTTON_POSITIVE).isEnabled = false
  }

  val textChangedListener = object : TextWatcher {
    override fun afterTextChanged(s: Editable?) {
      dialog.getButton(AlertDialog.BUTTON_POSITIVE).isEnabled = canSendGist(description, filename, content)
    }
    override fun beforeTextChanged(s: CharSequence?, p1: Int, p2: Int, p3: Int) {
    }
    override fun onTextChanged(s: CharSequence?, p1: Int, p2: Int, p3: Int) {
    }
  }

  description.addTextChangedListener(textChangedListener)
  filename.addTextChangedListener(textChangedListener)
  content.addTextChangedListener(textChangedListener)

  dialog.show()
}

private fun canSendGist(description: EditText, filename: EditText, content: EditText) =
    !description.text.isNullOrBlank() && !filename.text.isNullOrBlank() && !content.text.isNullOrBlank()