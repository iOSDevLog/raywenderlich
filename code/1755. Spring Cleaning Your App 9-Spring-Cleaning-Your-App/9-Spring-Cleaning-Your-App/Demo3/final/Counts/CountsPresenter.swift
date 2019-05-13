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
import CoreData

class CountsPresenter {

  private let scheduler: GrandCentralScheduler
  private let persistentContainer: NSPersistentContainer
  private weak var countsView: CountsView?

  init(countsView: CountsView) {
    self.countsView = countsView
    scheduler = GrandCentralScheduler()
    persistentContainer = NSPersistentContainer(name: "Model")
  }

  func getCounts() {
    persistentContainer.loadPersistentStores { _, maybeError in
      if let error = maybeError {
        self.countsView?.onCountsNotLoaded(with: error)
      } else {
        self.scheduler.inBackground(run: {
          return try self.counts()
        }, completedBy: { [weak self] counts in
          self?.countsView?.onCountsUpdated(counts)
          }, handlingErrorsBy: { [weak self] error in
            self?.countsView?.onCountsNotLoaded(with: error)
        })
      }
    }
  }

  private func counts() throws -> [Count] {
    let request: NSFetchRequest<StoredCount> = NSFetchRequest(entityName: "StoredCount")
    let storedCounts = try self.persistentContainer.viewContext.fetch(request) as [StoredCount]
    return storedCounts.reversed().compactMap({ storedCount -> Count? in
      guard let title = storedCount.title else {
        return nil
      }

      let increment = Int(storedCount.increment)
      let rawId = storedCount.objectID.uriRepresentation().absoluteString
      return Count(id: Count.Id(rawValue: rawId),
                   title: title,
                   count: Int(storedCount.currentCount),
                   total: Int(storedCount.goalCount),
                   interval: .weekly,
                   resetTime: Date(timeIntervalSinceNow: 60 * 60 * 24 * 4),
                   increment: increment)
    })
  }

  func increment(_ count: Count) {
    scheduler.inBackground(run: {
      let countId = count.id
      guard let url = URL(string: countId.rawValue),
        let id = self.persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url) else {
          return .noUpdate(from: try self.counts())
      }
      let backgroundContext = self.persistentContainer.newBackgroundContext()
      let object = backgroundContext.object(with: id) as! StoredCount
      object.currentCount = object.currentCount + Int32(1)
      try backgroundContext.save()
      return .updated(countId, in: try self.counts())
    }, completedBy: { [weak self] newCount in
      self?.countsView?.onCountIncremented(newCount)
    }, handlingErrorsBy: { error in
      print("Whoops! \(error)")
    })
  }

  func insert(_ countRequest: CountRequest) {
    scheduler.inBackground(run: {
      let insertionContext = self.persistentContainer.newBackgroundContext()
      let storedCount = NSEntityDescription.insertNewObject(forEntityName: "StoredCount", into: insertionContext) as! StoredCount
      storedCount.title = countRequest.title
      storedCount.currentCount = Int32(countRequest.count)
      storedCount.goalCount = Int32(countRequest.total)
      storedCount.increment = Int32(countRequest.increment)
      insertionContext.insert(storedCount)
      try insertionContext.save()
      let rawId = storedCount.objectID.uriRepresentation().absoluteString
      return .updated(Count.Id(rawValue: rawId), in: try self.counts())
    }, completedBy: { [weak self] counts in
      self?.countsView?.onCountInserted(counts)
    }, handlingErrorsBy: { error in
      print("Whoops!")
    })
  }
}
