import Foundation
// The playground must keep running until the asynchronous task completes:
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## Cookbook 1: iTunes Query Data Task
//: Default session with `waitsForConnectivity`:
let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let defaultSession = URLSession(configuration: config)
//: ### `Track`, `TrackList` and `QueryService`
struct Track: Decodable {
  let trackName: String
  let artistName: String
  let previewUrl: String
}

struct TrackList: Decodable {
  let results: [Track]
}

class QueryService {
  var tracks: [Track] = []
  var errorMessage = ""

  func getSearchResults() {
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!








  }

  func updateSearchResults(_ data: Data) {
    tracks.removeAll()







  }

}

QueryService().getSearchResults()
