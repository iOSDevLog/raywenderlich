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

package com.raywenderlich.android.datadrop.model

import android.content.Context
import android.util.Log
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.raywenderlich.android.datadrop.app.DataDropApplication
import java.io.*


object FileRepository : DropRepository {

  private val gson: Gson
    get() {
      val builder = GsonBuilder()
      builder.registerTypeAdapter(Drop::class.java, DropTypeAdapter())
      return builder.create()
    }

  private fun getContext() = DataDropApplication.getAppContext()

  override fun addDrop(drop: Drop) {
    val string = gson.toJson(drop)
    try {
      val dropStream = dropOutputStream(drop)
      dropStream.write(string.toByteArray())
      dropStream.close()
    } catch (e: IOException) {
      Log.e("FileRepository", "Error saving drop")
    }
  }

  override fun getDrops(): List<Drop> {
    return emptyList()
  }

  override fun clearDrop(drop: Drop) {

  }

  override fun clearAllDrops() {

  }

  private fun dropsDirectory() = getContext().getDir("drops", Context.MODE_PRIVATE)

  private fun dropFile(filename: String) = File(dropsDirectory(), filename)

  private fun dropFilename(drop: Drop) = drop.id + ".drop"

  private fun dropOutputStream(drop: Drop): FileOutputStream {
    return FileOutputStream(dropFile(dropFilename(drop)))
  }
}