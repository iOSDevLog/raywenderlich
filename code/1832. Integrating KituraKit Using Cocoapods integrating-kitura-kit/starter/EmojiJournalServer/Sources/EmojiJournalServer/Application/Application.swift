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
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import Health
import CouchDB

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public class App {
  let router = Router()
  let cloudEnv = CloudEnv()
  var connectionProperties: ConnectionProperties {
    #if os(macOS)
      Log.info("Running on MacOS - using local database")
      return ConnectionProperties(host: "localhost",
                                  port: 5984,
                                  secured: false)
    #elseif os(Linux)
      if let cloudCreds = cloudEnv.getCloudantCredentials(name: "Cloudant NoSQL DB-lq") {
        Log.info("Found cloud credentials for database")
        return ConnectionProperties(host: cloudCreds.host,
                                    port: Int16(cloudCreds.port),
                                    secured: cloudCreds.secured,
                                    username: cloudCreds.username,
                                    password: cloudCreds.password)
      } else {
        Log.info("Could not find cloud credentials for database - using localhost")
        return ConnectionProperties(host: "localhost",
                                    port: 5984,
                                    secured: false)
      }
    #endif
  }
  
  var client: CouchDBClient?
  var database: Database?

  func postInit() throws {
    client = CouchDBClient(connectionProperties: connectionProperties)
    client?.dbExists("entries", callback: { [weak self] exists, _ in
      guard let strongSelf = self else {
        return
      }
      if exists {
        Log.info("Journal entries database located - loading...")
        strongSelf.finalizeRoutes(with: Database(connProperties: strongSelf.connectionProperties,
                                                 dbName: "entries"))
      } else {
        strongSelf.createNewDatabase()
      }
    })
  }
  
  private func finalizeRoutes(with createdDatabase: Database) {
    database = createdDatabase
    initializeEntryRoutes(app: self)
    initializeMetrics(app: self)
    initializeHealthRoutes(app: self)
  }
  
  func createNewDatabase() {
    Log.info("Database does not exist - creating new database")
    client?.createDB("entries", callback: { [weak self] database, error in
      guard let strongSelf = self else {
        return
      }
      guard let database = database else {
        Log.error("Could not create new database: (\(String(describing: error?.localizedDescription))) - journal entry routes not created")
        return
      }
      strongSelf.finalizeRoutes(with: database)
    })
  }

  public func run() throws {
    try postInit()
    Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
    Kitura.run()
  }
}
