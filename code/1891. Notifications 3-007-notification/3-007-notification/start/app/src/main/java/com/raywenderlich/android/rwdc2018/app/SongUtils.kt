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

package com.raywenderlich.android.rwdc2018.app

import android.content.Context
import android.util.Log
import java.io.*
import java.net.URL

object SongUtils {
  fun download(urlString: String) {
    try {
      val songDir = songDirectory()
      if (!songDir.exists()) {
        songDir.mkdirs()
      }

      val f = songFile()
      val url = URL(urlString)

      val input: InputStream = BufferedInputStream(url.openStream())
      val output: OutputStream = FileOutputStream(f)

      val data = ByteArray(1024)

      var total = 0L
      var count = input.read(data)
      while (count != -1) {
        total++
        Log.i("SongUtils", "$total")

        output.write(data, 0, count)
        count = input.read(data)
      }

      output.flush()
      output.close()
      input.close()
    } catch (e: Exception) {
      e.printStackTrace()
    }
  }

  fun songDirectory() = RWDC2018Application.getAppContext().getDir(Constants.SONGS_DIRECTORY, Context.MODE_PRIVATE)

  fun songFile() = File(songDirectory(), Constants.SONG_FILENAME)
}