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
//: The sample app for this course is **HalfTunes**: it lets you search iTunes for songs,
//: and displays the search results in a `tableView`, 
//: then you can download and play 30-second snippets.
//: The main model object represents a song track:
struct Track: Decodable {
  let trackName: String
  let artistName: String
  let previewUrl: String
}
//: iTunes returns the query results as an array of `Tracks`:
struct TrackList: Decodable {
  let results: [Track]
}
//: The `Track` and `TrackList` property names match the keys in the iTunes JSON response. Both structs conform to the Decodable protocol, which will let us automate the JSON parsing.
//:
//: HalfTunes handles queries in the `QueryService` class:
//: `getSearchResults` creates the search url, then creates a data task on a session.
class QueryService {
  var tracks: [Track] = []
  var errorMessage = ""
//: The iTunes Search API is a REST API, with specific endpoints for search and lookup.
//: Here, we use the search endpoint:
  func getSearchResults() {
    let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")!
//: The default HTTP method is GET, so a GET data task only needs a url.
//: The simplest data task has a completion handler, which receives optional 
//: data, URLResponse, and error objects:
    let task = defaultSession.dataTask(with: url) { data, response, error in
      // When exiting the handler, the page can finish execution
      defer { PlaygroundPage.current.finishExecution() }
      
      if let error = error {
        self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
      } else if let data = data,
//: After checking for a network error, we cast the response as HTTPURLResponse,
//: to check the status code: 200 means OK:
        let response = response as? HTTPURLResponse,
        response.statusCode == 200 {
        self.updateSearchResults(data)
        // In a playground, we can just ask to see objects:
        self.tracks
        self.errorMessage
      }
    }
    task.resume()
  }
//: Session tasks are always created in a suspended state, so remember to call `resume()` to start it. 
//:
//: Converting response data to tracks happens in `updateSearchResults(_:)`.
//: The data returned by `dataTask`
//: is a JSON file, which we'll decode into a `TrackList`.
//: The [iTunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/) describes the keys and values in the response data,
//: so we know the value of the `results` key is an array of dictionaries.
//: And we've already created the `Track` struct with properties that match the keys in these dictionaries.
//: A `JSONDecoder` automatically converts the response data into an array of `Track` objects.
  func updateSearchResults(_ data: Data) {
    let decoder = JSONDecoder()
    tracks.removeAll()
//: `JSONDecoder` can throw an error, so we use a do-try-catch statement:
    do {
      let list = try decoder.decode(TrackList.self, from: data)
      tracks = list.results
    } catch let decodeError as NSError {
      errorMessage += "Decoder error: \(decodeError.localizedDescription)\n"
      return
    }
  }
}

//: ### Run `getSearchResults`
//: Run this playground, and you'll see the `tracks` array in the sidebar, beside the handler, above.
QueryService().getSearchResults()
