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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import AVKit
import AVFoundation

private extension Selector {
  static let dismissKeyboard = #selector(SearchViewController.dismissKeyboard)
}

typealias JSONDictionary = [String: Any]
typealias QueryResult = ([Track]?, String) -> ()

class SearchViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  var searchResults: [Track] = []
  var activeDownloads: [URL: Download] = [:]
  var dataTask: URLSessionDataTask?
  let defaultSession = URLSession(configuration: .default)
  
  lazy var tapRecognizer: UITapGestureRecognizer = {
    var recognizer = UITapGestureRecognizer(target:self, action: .dismissKeyboard)
    return recognizer
  }()
  
  // MARK: - View controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }
  
  // MARK: - Handling Search Results
  
  // This helper method helps parse response JSON NSData into an array of Track objects.
  func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    searchResults.removeAll()
    
    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      print("JSONSerialization error: \(parseError.localizedDescription)")
      return
    }
    
    // Get the results array
    guard let array = response!["results"] as? [Any] else {
      print("Dictionary does not contain results key")
      return
    }
    
    for trackDictionary in array {
      if let trackDictionary = trackDictionary as? JSONDictionary,
        let previewURLString = trackDictionary["previewUrl"] as? String,
        let previewURL = URL(string: previewURLString),
        let name = trackDictionary["trackName"] as? String,
        let artist = trackDictionary["artistName"] as? String {
        searchResults.append(Track(name: name, artist: artist, previewURL: previewURL))
      } else {
        print("Problem parsing trackDictionary")
      }
    }
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.tableView.setContentOffset(CGPoint.zero, animated: false)
    }
  }
  
  // MARK: - Keyboard dismissal
  
  @objc func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
  
  // MARK: - Download methods
  
  // Called when the Download button for a track is tapped
  func startDownload(_ track: Track) {
    let download = Download(url: track.previewURL)
    download.task = defaultSession.downloadTask(with: track.previewURL) { location, response, error in
			self.saveDownload(download: download, location: location, response: response, error: error)
    }
    download.task!.resume()
    download.isDownloading = true
    activeDownloads[download.url] = download
  }
	
	func saveDownload(download : Download, location : URL?, response : URLResponse?, error : Error?) {
		let sourceURL = download.url
		if error != nil { return }
		
		activeDownloads[sourceURL] = nil
		
		let destinationURL = localFilePath(for: sourceURL)
		
		let fileManager = FileManager.default
		try? fileManager.removeItem(at: destinationURL)
		do {
			try fileManager.copyItem(at: location!, to: destinationURL)
		} catch let error {
			print("Could not copy file to disk: \(error.localizedDescription)")
		}
		
		if let index = trackIndex(for: download.task!) {
			DispatchQueue.main.async {
				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
			}
		}
	}
	
  // Called when the Pause button for a track is tapped
  func pauseDownload(_ track: Track) {
		
		guard let download = activeDownloads[track.previewURL] else { return }
		download.task!.cancel(byProducingResumeData: { (data) in
			download.resumeData = data
		})
		
		download.isDownloading = false
		
		if let index = trackIndex(for: download.task!) {
			DispatchQueue.main.async {
				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
			}
		}
		
  }
	
  // Called when the Cancel button for a track is tapped
  func cancelDownload(_ track: Track) {
		
		guard let download = activeDownloads[track.previewURL] else { return }
		download.task!.cancel()
		download.isDownloading = false
		activeDownloads[track.previewURL] = nil
		
		if let index = trackIndex(for: download.task!) {
			DispatchQueue.main.async {
				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
			}
		}
		
  }
	
  // Called when the Resume button for a track is tapped
  func resumeDownload(_ track: Track) {
		
		guard let download = activeDownloads[track.previewURL] else { return }
		if let resumeData = download.resumeData {
			download.task = defaultSession.downloadTask(withResumeData: resumeData, completionHandler: { (location, response, error) in
				self.saveDownload(download: download, location: location, response: response, error: error)
			})
			
		}else {
			download.task = defaultSession.downloadTask(with: download.url, completionHandler: { (location, response, error) in
				self.saveDownload(download: download, location: location, response: response, error: error)
			})
		}
		
		download.task!.resume()
		download.isDownloading = true

		if let index = trackIndex(for: download.task!) {
			DispatchQueue.main.async {
				self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
			}
		}
		
  }
	
  // This method attempts to play the local file (if it exists) when the cell is tapped
  func playDownload(_ track: Track) {
    let playerViewController = AVPlayerViewController()
    present(playerViewController, animated: true, completion: nil)
    let url = localFilePath(for: track.previewURL)
    let player = AVPlayer(url: url)
    playerViewController.player = player
    player.play()
  }
  
  // MARK: Download helper methods
  
  // This method generates a permanent local file path to save a track to by appending
  // the lastPathComponent of the URL (i.e. the file name and extension of the file)
  // to the path of the app’s Documents directory.
  func localFilePath(for url: URL) -> URL {
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsPath.appendingPathComponent(url.lastPathComponent)
  }
  
  // This method checks if the local file exists at the path generated by localFilePathForUrl(_:)
  func localFileExists(for track: Track) -> Bool {
    let localUrl = localFilePath(for: track.previewURL)
    var isDir: ObjCBool = false
    return FileManager.default.fileExists(atPath: localUrl.path, isDirectory: &isDir)
  }
  
  fileprivate func trackIndex(for task: URLSessionDownloadTask) -> Int? {
    guard let url = (task.originalRequest ?? task.currentRequest)?.url else { return nil }
    let indexedTracks = searchResults.enumerated().filter() { $1.previewURL == url }
    return indexedTracks.first?.0
  }
  
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // Dimiss the keyboard
    dismissKeyboard()
    
    if !searchBar.text!.isEmpty {
      dataTask?.cancel()
      var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=song")
      urlComponents?.queryItems?.append(URLQueryItem(name: "term", value: searchBar.text!))
      guard let url = urlComponents?.url else { return }
      
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      
      dataTask = defaultSession.dataTask(with: url) { (data, response, error) in
        defer {
          self.dataTask = nil
        }
        
        DispatchQueue.main.async {
          UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        if let error = error {
          print(error.localizedDescription)
        } else if let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          self.updateSearchResults(data)
        }
      }
      dataTask?.resume()
    }
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition {
    return .topAttached
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    view.addGestureRecognizer(tapRecognizer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.removeGestureRecognizer(tapRecognizer)
  }
}

// MARK: - TrackCellDelegate

extension SearchViewController: TrackCellDelegate {
  func pauseTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      pauseDownload(track)
      tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
    }
  }
  
  func resumeTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      resumeDownload(track)
      tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
    }
  }
  
  func cancelTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      cancelDownload(track)
      tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
    }
  }
  
  func downloadTapped(_ cell: TrackCell) {
    if let indexPath = tableView.indexPath(for: cell) {
      let track = searchResults[indexPath.row]
      startDownload(track)
      tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .none)
    }
  }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: TrackCell = tableView.dequeueReusableCell(for: indexPath)
    
    // Delegate cell button tap events to this view controller
    cell.delegate = self
    
    let track = searchResults[indexPath.row]
    cell.configure(track: track, download: activeDownloads[track.previewURL], downloaded: localFileExists(for: track))
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 62.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let track = searchResults[indexPath.row]
    if localFileExists(for: track) {
      playDownload(track)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

