import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2: POST DataTask
//: Use ephemeral session:
let session = URLSession(configuration: .ephemeral)
//: ### HTTP Headers of GET DataTask
//: In the previous video, we worked with GET data tasks. GET is the default method for url-request, so we could create the data task directly from the url. Here's one without the completion handler, because we're only going to look at the properties of its current-request property. 
//:
//: Run your `json-server` in Terminal: `json-server --watch db.json`, then
//: run this playground to see the properties all have default values, except for the url:
let url = URL(string: "http://localhost:3000/posts/")!
let task = session.dataTask(with: url)
task.currentRequest?.url
task.currentRequest?.description
task.currentRequest?.httpMethod
task.currentRequest?.allowsCellularAccess // = false  // error: currentRequest is read-only
task.currentRequest?.httpShouldHandleCookies
task.currentRequest?.timeoutInterval
//: Hold down the option key, and click on these properties to see their description.
//:
//: No useful info appears for these next two properties, but inspect `currentRequest` with the Show Result button to see the `cachePolicy` raw value defaults to 0 `.useProtocolCachePolicy`. The protocol is usually HTTP.
task.currentRequest?.cachePolicy
task.currentRequest?.networkServiceType
task.currentRequest
task.currentRequest?.allHTTPHeaderFields
//: The default `allHTTPHeaderFields` property is empty, so `task` 
//: uses default values for headers accept-encoding, accept and accept-language.
//: The defaults are usually ok for GET tasks, but you'll need to create and configure
//: a `URLRequest` to set header fields for other tasks.
//:
//: ### POST DataTask with URLRequest
//: __DONE 1 of 13:__ To create a data task with a custom request, first create your request:
var request = URLRequest(url: url)  // inspect with Show Result button
//: __DONE 2 of 13:__ `URLRequest` is a struct, so declaring it as `var` allows us to modify its properties.
//: Specify a non-default cache policy and a network service type:
request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
request.networkServiceType = .background
//: __DONE 3 of 13:__ Specify this request accesses the network only on wi-fi —
//: faster, less battery drain, and it preserves the user's data quota:
request.allowsCellularAccess = false
//: __DONE 4 of 13:__ When the request is ready, create the data task:
let taskWithRequest = session.dataTask(with: request)
//: __DONE 5 of 13:__ Check the task's `httpMethod` property:
taskWithRequest.currentRequest?.httpMethod
//: __DONE 6 of 13:__ Change the request's `httpMethod` property to __POST__:
request.httpMethod = "POST"
//: __DONE 7 of 13:__ To send JSON, not an encoded form, set the header field __content-type__ to __application/json__:
request.addValue("application/json", forHTTPHeaderField: "content-type")
//: __DONE 8 of 13:__ A POST task __sends__ data, so JSON-encode a `Post` object for the request's `httpBody`:
struct Post: Codable {
//  let id: Int
  let author: String
  let title: String
}
let encoder = JSONEncoder()
let post = Post(author: "us", title: "all together now")
do {
  let data = try encoder.encode(post)
  request.httpBody = data
} catch let encodeError as NSError {
  print("Encoder error: \(encodeError.localizedDescription)\n")
  PlaygroundPage.current.finishExecution()
}
//: __DONE 9 of 13:__ Check the `taskWithRequest` properties:
taskWithRequest.currentRequest?.httpMethod
//: __DONE 10 of 13:__ Just one setting shows that you must set up the request completely _before_ creating the task, so create another task, with the now-complete `request`, and set up its handler to JSON-decode the response data:
let postTask = session.dataTask(with: request) { data, response, error in
  defer { PlaygroundPage.current.finishExecution() }
  guard let data = data, let response = response as? HTTPURLResponse,
    response.statusCode == 201 else {
      print("No data or statusCode not CREATED")
      return
  }

  let decoder = JSONDecoder()
  do {
    let post = try decoder.decode(Post.self, from: data)
    // decoded data is just the Post we created on json-server
    post
  } catch let decodeError as NSError {
    print("Decoder error: \(decodeError.localizedDescription)\n")
    return
  }
}
//: __DONE 11 of 13:__ Check the task's `httpMethod`, header fields and `httpBody`:
postTask.currentRequest?.httpMethod
postTask.currentRequest?.allHTTPHeaderFields
postTask.currentRequest?.httpBody
//: __DONE 12 of 13:__ `resume` the task, to run it:
//postTask.resume() // uncomment this to run the POST task
//: __DONE 13 of 13:__ Check the task's `httpBody` again:
postTask.currentRequest?.httpBody
