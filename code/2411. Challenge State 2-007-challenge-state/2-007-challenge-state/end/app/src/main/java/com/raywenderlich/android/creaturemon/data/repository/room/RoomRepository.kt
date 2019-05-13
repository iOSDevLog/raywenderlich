/*
 * Copyright (c) 2019 Razeware LLC
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

package com.raywenderlich.android.creaturemon.data.repository.room

import android.os.AsyncTask
import com.raywenderlich.android.creaturemon.app.CreaturemonApplication
import com.raywenderlich.android.creaturemon.data.model.Creature
import com.raywenderlich.android.creaturemon.data.repository.CreatureRepository
import io.reactivex.Observable
import io.reactivex.subjects.PublishSubject

class RoomRepository : CreatureRepository {

  private val creatureDao: CreatureDao = CreaturemonApplication.database.creatureDao()

  private val allCreatures: Observable<List<Creature>>

  private var saveSubject: PublishSubject<Boolean> = PublishSubject.create()
  private val clearSubject: PublishSubject<Boolean> = PublishSubject.create()

  init {
    allCreatures = creatureDao.getAllCreatures()
  }

  override fun saveCreature(creature: Creature): Observable<Boolean> {
    saveSubject = PublishSubject.create()
    if (canSaveCreature(creature)) {
      InsertAsyncTask(creatureDao) {
        saveSubject.onNext(true)
      }.execute(creature)
    } else {
      saveSubject.onError(Error("Please fill in all fields."))
    }
    return saveSubject
  }

  private fun canSaveCreature(creature: Creature): Boolean {
    return creature.drawable != 0 &&
        creature.name.isNotEmpty() &&
        creature.attributes.intelligence != 0 &&
        creature.attributes.strength != 0 &&
        creature.attributes.endurance !=0
  }

  override fun getAllCreatures() = allCreatures

  override fun clearAllCreatures(): Observable<Boolean> {
    DeleteAsyncTask(creatureDao) {
      clearSubject.onNext(true)
    }.execute()
    return clearSubject
  }

  private class InsertAsyncTask internal constructor(private val dao: CreatureDao,
                                                     private val completed: () -> Unit) : AsyncTask<Creature, Void, Void>() {
    override fun doInBackground(vararg params: Creature): Void? {
      dao.insert(params[0])
      return null
    }

    override fun onPostExecute(result: Void?) {
      super.onPostExecute(result)
      completed()
    }
  }

  private class DeleteAsyncTask internal constructor(private val dao: CreatureDao,
                                                     private val completed: () -> Unit) : AsyncTask<Void, Void, Void>() {
    override fun doInBackground(vararg params: Void): Void? {
      dao.clearAllCreatures()
      return null
    }

    override fun onPostExecute(result: Void?) {
      super.onPostExecute(result)
      completed()
    }
  }
}