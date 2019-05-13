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

package com.raywenderlich.android.w00tze.ui.main

import android.arch.lifecycle.ViewModelProviders
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.Uri
import android.os.Bundle
import android.support.design.widget.BottomNavigationView
import android.support.v4.app.Fragment
import android.support.v7.app.AppCompatActivity
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast
import com.raywenderlich.android.w00tze.BuildConfig
import com.raywenderlich.android.w00tze.R
import com.raywenderlich.android.w00tze.ui.gists.GistsFragment
import com.raywenderlich.android.w00tze.ui.profile.ProfileFragment
import com.raywenderlich.android.w00tze.ui.repos.ReposFragment
import com.raywenderlich.android.w00tze.viewmodel.MainViewModel
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {

  private val reposFragment = ReposFragment()
  private val gistsFragment = GistsFragment()
  private val profileFragment = ProfileFragment()

  private lateinit var mainViewModel: MainViewModel

  private val onNavigationItemSelectedListener = BottomNavigationView.OnNavigationItemSelectedListener { item ->
    val fragment = when (item.itemId) {
      R.id.navigation_repos -> reposFragment
      R.id.navigation_gists -> gistsFragment
      R.id.navigation_profile -> profileFragment
      else -> ReposFragment()
    }
    switchToFragment(fragment)
    true
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_main)

    mainViewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)

    navigation.setOnNavigationItemSelectedListener(onNavigationItemSelectedListener)

    switchToFragment(reposFragment)

    checkConnectivity()
  }

  override fun onResume() {
    super.onResume()

    val uri = intent.data
    if (uri != null && uri.toString().startsWith(BuildConfig.REDIRECT_URI)) {
      mainViewModel.getAccessToken(uri) {
        switchToFragment(reposFragment)
      }
    }
  }

  override fun onCreateOptionsMenu(menu: Menu): Boolean {
    super.onCreateOptionsMenu(menu)
    menuInflater.inflate(R.menu.menu_main, menu)
    return true
  }

  override fun onOptionsItemSelected(item: MenuItem): Boolean {
    when (item.itemId) {
      R.id.login_menu_item -> startLogin()
      R.id.logout_menu_item -> logout()
    }
    return super.onOptionsItemSelected(item)
  }

  private fun startLogin() {
    if (!mainViewModel.isAuthenticated()) {
      showUsernameDialog {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(
            "https://github.com/login/oauth/authorize?client_id=${BuildConfig.CLIENT_ID}&scope=user%20gist&redirect_uri=${BuildConfig.REDIRECT_URI}"))
        startActivity(intent)
      }
    }
  }

  private fun logout() {
    mainViewModel.logout()
    switchToFragment(reposFragment)
  }

  private fun switchToFragment(fragment: Fragment) {
    val transaction = supportFragmentManager.beginTransaction()
    transaction.replace(R.id.main_container, fragment).commit()
  }

  private fun checkConnectivity() {
    val cm = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val activeNetwork = cm.activeNetworkInfo
    val isConnected = activeNetwork != null && activeNetwork.isConnectedOrConnecting
    if (!isConnected) {
      Toast.makeText(this, "Check network connection", Toast.LENGTH_SHORT).show()
    }
  }
}
