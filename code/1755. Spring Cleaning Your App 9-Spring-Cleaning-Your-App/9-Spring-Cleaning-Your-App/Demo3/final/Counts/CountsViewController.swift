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
  let updated: [Count.Id]

  static func noUpdate(from counts: [Count]) -> IncrementalUpdate {
    return IncrementalUpdate(counts: counts, updated: [])
  }

  static func updated(_ countId: Count.Id, in counts: [Count]) -> IncrementalUpdate {
    return IncrementalUpdate(counts: counts, updated: [countId])
  }
}

typealias CountsHandler = ([Count]) -> Void
typealias IncrementalUpdateHandler = (IncrementalUpdate) -> Void
typealias ErrorHandler = (Error) -> Void

class CountsViewController: UIViewController, UITableViewDelegate, AddCountViewDelegate, CountsView {

  private let tableView = UITableView()
  private let adapter = UITableViewAdapter { (count: Count, cell: CountTableCell) in
    cell.bind(to: count)
  }

  var countsView: CountsView? {
    return self
  }

  private lazy var presenter = CountsPresenter(countsView: self)

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

    presenter.getCounts()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let selectedCount = adapter.item(at: indexPath)
    presenter.increment(selectedCount)

    tableView.deselectRow(at: indexPath, animated: true)
  }

  func addCountView(_ view: AddCountView, didFinishCreating count: CountRequest) {
    presenter.insert(count)
  }

  func onCountsUpdated(_ counts: [Count]) {
    adapter.update(with: counts)
    tableView.reloadData()
  }

  func onCountIncremented(_ update: IncrementalUpdate) {
    adapter.update(with: update.counts)
    tableView.reloadRows(at: update.updatedIndexes.asIndexPaths(), with: .automatic)
  }

  func onCountInserted(_ update: IncrementalUpdate) {
    adapter.update(with: update.counts)
    tableView.insertRows(at: update.updatedIndexes.asIndexPaths(), with: .automatic)
  }

  func onCountsNotLoaded(with error: Error) {
    print(error)
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
