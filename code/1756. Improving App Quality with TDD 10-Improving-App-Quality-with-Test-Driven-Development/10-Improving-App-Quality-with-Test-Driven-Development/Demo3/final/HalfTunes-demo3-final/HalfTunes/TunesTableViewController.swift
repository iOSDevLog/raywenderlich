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

class TunesTableViewController: UITableViewController {

  var queryService: QueryService? = nil
  var tunes: [Tune]? = nil
  var application: URLOpening = UIApplication.shared

  override func viewDidLoad() {
    super.viewDidLoad()

    queryService = QueryService()
    search(searchTerm: "swift")
  }

  func search(searchTerm: String) {
    queryService?.getSearchResults(searchTerm: searchTerm) { [weak self] tunes in
      self?.tunes = tunes
      self?.tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource
extension TunesTableViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tunes?.count ?? 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "tuneCell", for: indexPath)

    guard let tunes = tunes else {
      return cell
    }

    let thisTune = tunes[indexPath.row]
    cell.textLabel?.text = "\(thisTune.artist) - \(thisTune.name)"
    cell.detailTextLabel?.text = thisTune.formattedDate()

    return cell
  }
}

// MARK: - UITableViewDelegate
extension TunesTableViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let tunes = tunes else {
      return
    }

    let selectedTune  = tunes[indexPath.row]
    guard let trackURL = URL(string: selectedTune.trackViewUrl) else {
      return
    }

    application.open(trackURL, options: [:], completionHandler: nil)
  }
}

protocol URLOpening {
  func open(_ url: URL, options: [String : Any], completionHandler: ((Bool) -> Void)?)
}

// MARK: - URLOpening
extension UIApplication: URLOpening {
}
