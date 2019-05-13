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
import SwiftyJSON

// MARK: - JournalEntry Persistence
extension JournalEntry {
  class Persistence {
    static func getAll(from database: Database, callback: @escaping (_ entries: [JournalEntry]?, _ error: NSError?) -> Void) {
      database.retrieveAll(includeDocuments: true) { documents, error in
        guard let documents = documents else {
          callback(nil, error)
          return
        }
        var entries = [JournalEntry]()
        for document in documents["rows"].arrayValue {
          let id = document["id"].stringValue
          let emoji = document["doc"]["emoji"].stringValue
          guard let date = document["doc"]["date"].dateTime else {
            continue
          }
          if let entry = JournalEntry(id: id, emoji: emoji, date: date) {
            entries.append(entry)
          }
        }
        callback(entries, nil)
      }
    }
    
    static func save(entry: JournalEntry, to database: Database, callback: @escaping (_ entryID: String?, _ error: NSError?) -> Void) {
      getAll(from: database) { entries, error in
        guard let entries = entries else {
          return callback(nil, error)
        }
        for newEntry in entries where entry == newEntry {
          return callback(nil, NSError(domain: "EmojiJournal",
                                       code: 400,
                                       userInfo: ["localizedDescription": "Duplicate entry"]))
        }
        let body = JSON(["emoji": entry.emoji,
                         "date": entry.date.iso8601])
        database.create(body) { id, _, _, error in
          callback(id, error)
        }
      }
    }
    
    static func get(from database: Database, with entryID: String, callback: @escaping (_ entry: JournalEntry?, _ error: NSError?) -> Void) {
      database.retrieve(entryID) { document, error in
        guard let document = document else {
          return callback(nil, error)
        }
        guard let date = document["date"].dateTime else {
          return callback(nil, error)
        }
        guard let entry = JournalEntry(id: document["_id"].stringValue, emoji: document["emoji"].stringValue, date: date) else {
          return callback(nil, error)
        }
        callback(entry, nil)
      }
    }
    
    static func delete(entryWith id: String, from database: Database, callback: @escaping (_ error: NSError?) -> Void) {
      database.retrieve(id) { document, error in
        guard let document = document else {
          return callback(error)
        }
        let id = document["_id"].stringValue
        let revision = document["_rev"].stringValue
        database.delete(id, rev: revision, callback: { error in
          callback(error)
        })
      }
    }
  }
}
