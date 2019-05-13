import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2 Challenge
//: ### PUT to json-server
//: This page shows the standard way to create a PUT request. __Sources/PostRouter.swift__ contains the `PostRouter` enum. Go to the next playground page to use it.
//:
//: The session and `Post` struct:
let session = URLSession(configuration: .ephemeral)
//: The url for **post 1** and the request:
let putUrl = URL(string: "http://localhost:3000/posts/1")!
var putRequest = URLRequest(url: putUrl)
//: Configure the request to update post 1 to `["author": "an old friend", "title": "an old title"]`
putRequest.httpMethod = "PUT"
putRequest.addValue("application/json", forHTTPHeaderField: "content-type")
let post = Post(author: "an old friend", title: "an old title")
let encoder = JSONEncoder()
do {
  let data = try encoder.encode(post)
  putRequest.httpBody = data
} catch let encodeError as NSError {
  print("Encoder error: \(encodeError.localizedDescription)\n")
  PlaygroundPage.current.finishExecution()
}
//: Create a data task with a completion handler that checks for `data`,
//: `response` with status code 200, then decodes `data` to display the updated `Post`:
let putTask = session.dataTask(with: putRequest) { data, response, error in
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

//: [With PostRouter](@next)

