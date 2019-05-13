/*
 * Copyright (c) 2017 Razeware LLC
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

package com.raywenderlich.propertyfinder

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.ProgressBar
import android.widget.TextView
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.*

class MainActivity : AppCompatActivity() {
    private var mResults: List<Listing>? = null

    private val mApiService by lazy {
        NestoriaService.create()
    }

    private var mSpinner: ProgressBar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val searchButton = findViewById<Button>(R.id.searchButton)
        val searchText = findViewById<TextView>(R.id.searchText)
        searchText.setText(R.string.default_place)
        mSpinner = findViewById(R.id.progressBar)
        mSpinner!!.visibility = View.GONE
        searchButton.setOnClickListener {
            Log.d("PropertyFinder", searchText.text.toString())
            //loadLocalResults()
            loadApiResults(searchText.text.toString())
        }
    }

    private fun displayResults() {
        val intent = Intent(this, ResultsActivity::class.java)
        intent.putParcelableArrayListExtra("SearchResults", mResults as ArrayList<Listing>)
        startActivity(intent)
    }

    private fun loadLocalResults() {
        val fileData = applicationContext
                .assets.open("data/search_results_sample.json")
                .bufferedReader()
                .use {
                    it.readText()
                }
        val gson = Gson()
        val propertyListType = object : TypeToken<List<Listing>>() {}.type
        mResults = gson.fromJson(fileData, propertyListType)
        displayResults()
    }

    private fun loadApiResults(place: String) {
        mSpinner!!.visibility = View.VISIBLE
        val parameters = HashMap<String, String>()
        parameters.put("country", "uk")
        parameters.put("page", "1")
        parameters.put("pretty", "1")
        parameters.put("encoding", "json")
        parameters.put("listing_type", "buy")
        parameters.put("action", "search_listings")
        parameters.put("place_name", place)
        val call = mApiService.searchListings(parameters)
        call.enqueue(object: Callback<NestoriaResult> {
            override fun onFailure(call: Call<NestoriaResult>?, t: Throwable?) {
                mSpinner!!.visibility = View.GONE
                Log.d("PropertyFinder", "Something went wrong")
            }

            override fun onResponse(
                    call: Call<NestoriaResult>?, response: Response<NestoriaResult>?) {
                mSpinner!!.visibility = View.GONE
                if (response != null && response.isSuccessful && response.body() != null) {
                    val serviceResponse = response.body()
                    mResults = serviceResponse?.response?.listings
                    if (mResults != null) {
                        displayResults()
                    } else {
                        Log.d("PropertyFinder", "Something went wrong")
                    }
                } else {
                    Log.d("PropertyFinder", "Something went wrong")
                }
            }

        })
    }
}
