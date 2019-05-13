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

import LoggerAPI
import KituraStencil
import Kitura
import CouchDB

private var database: Database?

func initializeWebClientRoutes(app: App) {
  database = app.database
  
  app.router.setDefault(templateEngine: StencilTemplateEngine())
  app.router.all(middleware: StaticFileServer(path: "./public"))
  app.router.get("/client", handler: showClient)
  
  Log.info("Web client routes created")
}

func showClient(request: RouterRequest, response: RouterResponse, next: @escaping () -> Void) {
  guard let database = database else {
    response.status(.serviceUnavailable).send(json: ["Message": "CouchDB Unavailable"])
    return
  }
  JournalEntry.Persistence.getAll(from: database, callback: { entries, error in
    guard let entries = entries else {
      response.status(.serviceUnavailable).send(json: ["Message": error?.localizedDescription])
      return
    }
    let sortedEntries = entries.sorted(by: {
      $0.date.timeIntervalSince1970 > $1.date.timeIntervalSince1970
    })
    var context = [String: Any]()
    var contextEntries = [[String: Any]]()
    for entry in sortedEntries {
      if let id = entry.id {
        let map = ["emoji": entry.emoji,
                   "date": entry.date.displayDate,
                   "id": id,
                   "time": entry.date.displayTime,
                   "emojiBGColor": entry.backgroundColorCode]
        contextEntries.append(map)
      }
    }
    context["entries"] = contextEntries
    do {
      try response.render("home.stencil", context: context)
    } catch let error {
      response.status(.internalServerError).send(error.localizedDescription)
    }
  })
}

// MARK: - JournalEntry backgroundColorCode
fileprivate extension JournalEntry {
  var backgroundColorCode: String {
    guard let substring = id?.suffix(6).uppercased() else {
      return "000000"
    }
    return substring
  }
}
