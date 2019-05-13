/**
 * Copyright (c) 2017 Razeware LLC
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


import UIKit
import Foundation

class MasterViewController: UITableViewController {

  var tracks: [Track] = []
  let session = URLSession(configuration: .default)
  let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/hot-tracks-country/10/non-explicit.json"
  let decoder = JSONDecoder()

  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchList()
  }

  // MARK: - Helper functions
  fileprivate func fetchList() {
    let task = session.dataTask(with: URL(string: urlString)!) { data, response, error in
      if let response = response as? HTTPURLResponse { print(response.statusCode) }
      guard let data = data else { return }
      self.updateList(data)
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
    task.resume()
  }

  fileprivate func updateList(_ data: Data) {
    let list = try! decoder.decode(TrackList.self, from: data)
    tracks = list.feed.results
  }

  // MARK: - Actions
  @IBAction func refreshList(_ sender: Any) {
    fetchList()
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
    let track = tracks[indexPath.row]
    cell.textLabel!.text = "\(1 + indexPath.row): \(track.name)"
    cell.detailTextLabel?.text = track.artistName
    return cell
  }

}

// MARK: - URLSession delegate methods

extension MasterViewController: URLSessionDelegate {

  func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let completionHandler = appDelegate.backgroundSessionCompletionHandler {
        appDelegate.backgroundSessionCompletionHandler = nil
        completionHandler()
      }
    }
  }

}

