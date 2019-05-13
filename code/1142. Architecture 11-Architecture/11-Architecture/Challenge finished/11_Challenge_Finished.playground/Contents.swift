import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## Operations Challenge: PUT to json-server then GET to check
//: __Instructions:__ Do the TODOs to complete the PUT operation 
//: — it's much simpler than `GetPostOperation`, which is already written.
//: Then create operation objects and make the GET
//: operation dependent on the PUT operation.
//: Finally, add the operations to an operation queue, and wait until finished,
//: to see the GET operation's output.
let session = URLSession(configuration: .ephemeral)
//: ### PUT operation
//: This operation takes a PUT request as input,
//: and prints `response.statusCode` in the data task's completion handler.
class PutPostOperation: AsyncOperation {
  // DONE 1 of 6: Declare input
  var putRequest: URLRequest

  // DONE 2 of 6: Write init method
  init(putRequest: URLRequest) {
    self.putRequest = putRequest
  }

  override func main() {
    // DONE 3 of 6: Create and resume a data task with request and completion handler.
    // In the handler, print response.statusCode, and set self.state to .finished.
    session.dataTask(with: putRequest) { _, response, _ in
      if let response = response as? HTTPURLResponse {
        print(response.statusCode)
      }
      self.state = .finished
    }.resume()
  }
}
//: ### GET operation
//: This operation takes a GET request as input, and outputs an array of Post authors.
class GetPostOperation: AsyncOperation {
  var getRequest: URLRequest
  var authors: [String] = []
  var posts: [Post] = []

  init(getRequest: URLRequest) {
    self.getRequest = getRequest
  }
  
  override func main() {
    session.dataTask(with: getRequest) { data, response, error in
      defer { PlaygroundPage.current.finishExecution() }
      guard let data = data, let response = response as? HTTPURLResponse,
        response.statusCode == 200 else {
          print("No data or statusCode not OK")
          return
      }

      let decoder = JSONDecoder()
      do {
        self.posts = try decoder.decode([Post].self, from: data)
        self.authors = self.posts.map { (post) -> String in
          return post.author }
      } catch let decodeError as NSError {
        print("Decoder error: \(decodeError.localizedDescription)\n")
        return
      }
      
      self.state = .finished
    }.resume()
  }
}
//: ### Operations & Dependency
let update = Post(author: "Part 11", title: "Put Operation")
let putRequest = PostRouter.update(1, update).asURLRequest()
let getRequest = PostRouter.getAll.asURLRequest()

// DONE 4 of 6: Create PutPostOperation and GetPostOperation object
// with putRequest and getRequest
let putOp = PutPostOperation(putRequest: putRequest)
let getOp = GetPostOperation(getRequest: getRequest)
// DONE 5 of 6: Add dependency on PUT operation to getOp
getOp.addDependency(putOp)
// DONE 6 of 6: Add operations to a new OperationQueue, and waitUntilFinished
OperationQueue().addOperations([getOp, putOp], waitUntilFinished: true)
// Show output of getOp
getOp.authors
getOp.posts
//: Run your `json-server` in Terminal: `json-server --watch db.json`, then run this playground.
//: You can double-check the result in RESTed by GETting all posts.
