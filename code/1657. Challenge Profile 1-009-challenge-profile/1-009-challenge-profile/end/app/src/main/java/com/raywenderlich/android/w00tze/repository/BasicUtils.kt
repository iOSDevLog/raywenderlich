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

package com.raywenderlich.android.w00tze.repository

import java.io.BufferedReader
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import javax.net.ssl.HttpsURLConnection


@Throws(IOException::class)
internal fun getUrlAsString(urlAddress: String): String {
  val url = URL(urlAddress)

  val conn = url.openConnection() as HttpsURLConnection

  conn.requestMethod = "GET"
  conn.setRequestProperty("Accept", "application/json")

  return try {
    val inputStream = conn.inputStream

    if (conn.responseCode != HttpURLConnection.HTTP_OK) {
      throw IOException("${conn.responseMessage} for $urlAddress")
    }

    if (inputStream != null) {
      convertStreamToString(inputStream)
    } else {
      "Error retrieving $urlAddress"
    }
  } finally {
    conn.disconnect()
  }
}

@Throws(IOException::class)
private fun convertStreamToString(inputStream: InputStream): String {
  val reader = BufferedReader(InputStreamReader(inputStream))
  val sb = StringBuilder()
  var line: String? = reader.readLine()
  while (line != null) {
    sb.append(line).append("\n")
    line = reader.readLine()
  }
  reader.close()
  return sb.toString()
}