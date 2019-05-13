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

package com.raywenderlich.android.w00tze.ui.profile

import android.support.v7.app.AlertDialog
import android.widget.EditText
import com.raywenderlich.android.w00tze.R
import kotlinx.android.synthetic.main.fragment_profile.*


internal fun ProfileFragment.showCompanyDialog(currentCompany: String, callback: (newCompany: String) -> Unit) {
  val dialogBuilder = AlertDialog.Builder(company.context)
  val dialogView = this.layoutInflater.inflate(R.layout.dialog_company, null)
  dialogBuilder.setView(dialogView)

  val companyEditText = dialogView.findViewById(R.id.companyEditText) as EditText
  companyEditText.setText(currentCompany)

  dialogBuilder.setTitle(getString(R.string.company_title))
  dialogBuilder.setPositiveButton(getString(R.string.company_ok), { _, _ ->
    callback(companyEditText.text.toString())
  })
  dialogBuilder.setNegativeButton(getString(R.string.cancel), { _, _ ->
    //pass
  })

  val dialog = dialogBuilder.create()
  dialog.show()
}
