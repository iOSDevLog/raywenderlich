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

import UIKit
import CoreData

struct IncrementalUpdate {

  let counts: [Count]
  let updated: [String]

  static func noUpdate(from counts: [Count]) -> IncrementalUpdate {
    return IncrementalUpdate(counts: counts, updated: [])
  }

  static func updated(_ countId: String, in counts: [Count]) -> IncrementalUpdate {
    return IncrementalUpdate(counts: counts, updated: [countId])
  }

}

typealias CountsHandler = ([Count]) -> Void
typealias IncrementalUpdateHandler = (IncrementalUpdate) -> Void
typealias ErrorHandler = (Error) -> Void

class CountsViewController: UIViewController, UITableViewDelegate, AddCountViewDelegate {

  private let tableView = UITableView()
  private var scheduler: GrandCentralScheduler!
  private var persistentContainer: NSPersistentContainer!
  private let adapter = UITableViewAdapter { (count: Count, cell: CountTableCell) in
    cell.bind(to: count)
  }

  init() {
    super.init(nibName: nil, bundle: nil)
    tabBarItem = UITabBarItem(title: "Counts", image: #imageLiteral(resourceName: "first"), selectedImage: nil)
    navigationItem.title = "Counts"
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    let addCountView = AddCountView(delegate: self)
    view.addSubview(addCountView)
    addCountView.constrainToSuperview([.leading, .trailing])
    addCountView.constrainToSafeAreaTop(of: self)
    addCountView.hugContent(.vertical)

    view.addSubview(tableView)
    tableView.constrainToSuperview([.leading, .trailing])
    tableView.constrainToSafeAreaBottom(of: self)
    tableView.constrain(.top, to: addCountView, .bottom)
    tableView.register(CountTableCell.self, forCellReuseIdentifier: "foo")
    tableView.dataSource = adapter
    tableView.delegate = self
    tableView.tableFooterView = UIView(frame: .zero)

    scheduler = GrandCentralScheduler()
    persistentContainer = NSPersistentContainer(name: "Model")
    getCounts(then: { [weak self] counts in
      self?.adapter.update(with: counts)
      self?.tableView.reloadData()
      }, onError: { error in
        print(error)
    })
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedCount = adapter.item(at: indexPath)
    increment(selectedCount) { [weak self] update in
      self?.adapter.update(with: update.counts)
      self?.tableView.reloadRows(at: update.updatedIndexes.asIndexPaths(), with: .automatic)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }

  func addCountView(_ view: AddCountView, didFinishCreating count: Count) {
    insert(count) { [weak self] update in
      self?.adapter.update(with: update.counts)
      self?.tableView.insertRows(at: update.updatedIndexes.asIndexPaths(), with: .automatic)
    }
  }

  func getCounts(then handler: @escaping CountsHandler, onError errorHandler: @escaping ErrorHandler) {
    persistentContainer.loadPersistentStores { _, maybeError in
      if let error = maybeError {
        errorHandler(error)
      } else {
        self.scheduler.inBackground(run: {
          return try self.counts()
        }, completedBy: { counts in
          handler(counts)
        }, handlingErrorsBy: { error in
          errorHandler(error)
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
      return Count(id: rawId,
                   title: title,
                   count: Int(storedCount.currentCount),
                   total: Int(storedCount.goalCount),
                   interval: .weekly,
                   resetTime: Date(timeIntervalSinceNow: 60 * 60 * 24 * 4),
                   increment: increment)
    })
  }

  func increment(_ count: Count, then resultHandler: @escaping IncrementalUpdateHandler) {
    scheduler.inBackground(run: {
      guard let countId = count.id,
        let url = URL(string: countId),
        let id = self.persistentContainer.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url) else {
          return .noUpdate(from: try self.counts())
      }

      let backgroundContext = self.persistentContainer.newBackgroundContext()
      let object = backgroundContext.object(with: id) as! StoredCount
      object.currentCount = object.currentCount + Int32(1)

      try backgroundContext.save()
      return .updated(countId, in: try self.counts())
    }, completedBy: { update in
      resultHandler(update)
    }, handlingErrorsBy: { error in
      print("Whoops! \(error)")
    })
  }

  func insert(_ countRequest: Count, then resultHandler: @escaping IncrementalUpdateHandler) {
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
      return .updated(rawId, in: try self.counts())
    }, completedBy: { counts in
      resultHandler(counts)
    }, handlingErrorsBy: { error in
      print("Whoops!")
    })
  }

}

enum RepositoryError: Error {
  case deniedAccess
  case accessError
}

fileprivate extension IncrementalUpdate {

  var updatedIndexes: [Int] {
    get {
      return updated.compactMap({ id in
        return counts.index(where: { count in
          return count.id == id
        })
      })
    }
  }
}

extension Array where Element == Int {

  func asIndexPaths(inSection section: Int = 0) -> [IndexPath] {
    return map { IndexPath(row: $0, section: section) }
  }
}
