//: [Request without PostRouter](@previous)

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2 Challenge
//: ### PUT to json-server
//: Use ephemeral session:
let session = URLSession(configuration: .ephemeral)
//: __DONE:__ After completing the `PostRouter` enum in Sources, use it to replace the two lines below, with the complete PUT request to update __posts/1__ to `["author": "a friend of Alamofire", "title": "Using PostRouter"]`:
let putPost = Post(author: "a friend of Alamofire", title: "Using PostRouter")
let putRequest = PostRouter.update(1, putPost).asURLRequest()
//: __Note:__ You must explicitly call `asURLRequest()`, because we're not using Alamofire's `URLRequestConvertible` protocol.
//: Here's the code from the previous page, to create a data task with a completion handler that checks for `data`,
//: `response` with status code 200, then decodes `data` to a `PostWithId`:
let putTask = session.dataTask(with: putRequest) { data, response, error in
  // handler just shows us what we updated on json-server
  defer { PlaygroundPage.current.finishExecution() }
  guard let data = data, let response = response as? HTTPURLResponse,
    response.statusCode == 200 else {
      print("No data or statusCode not OK")
      return
    }
    
  let decoder = JSONDecoder()
  do {
    let post = try decoder.decode(PostWithId.self, from: data)
    // decoded data is just the Post we updated on json-server
    post
  } catch let decodeError as NSError {
    print("Decoder error: \(decodeError.localizedDescription)\n")
    return
  }
}
putTask.resume()
//: Run your `json-server` in Terminal: `json-server --watch db.json`, then run this playground.
//: You can double-check the result in RESTed by GETting all posts.
