/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import CouchDB
import LoggerAPI
import KituraContracts

private var database: Database?

func initializeEntryRoutes(app: App) {
  database = app.database
  
  app.router.get("/entries", handler: getAllEntries)
  app.router.post("/entries", handler: addEntry)
  app.router.delete("/entries", handler: deleteEntry)
  
  Log.info("Journal entry routes created")
}

func getAllEntries(completion: @escaping ([JournalEntry]?, RequestError?) -> Void) -> Void {
  guard let database = database else {
    return completion(nil, .internalServerError)
  }
  JournalEntry.Persistence.getAll(from: database) { entries, error in
    return completion(entries, error as? RequestError)
  }
}

func addEntry(entry: JournalEntry, completion: @escaping (JournalEntry?, RequestError?) -> Void) {
  guard let database = database else {
    return completion(nil, .internalServerError)
  }
  JournalEntry.Persistence.save(entry: entry, to: database) { id, error in
    guard let id = id else {
      return completion(nil, .notAcceptable)
    }
    JournalEntry.Persistence.get(from: database, with: id, callback: { newEntry, error in
      return completion(newEntry, error as? RequestError)
    })
  }
}

func deleteEntry(id: String, completion: @escaping (RequestError?) -> Void) {
  guard let database = database else {
    return completion(.internalServerError)
  }
  JournalEntry.Persistence.delete(entryWith: id, from: database) { error in
    return completion(error as? RequestError)
  }
}
