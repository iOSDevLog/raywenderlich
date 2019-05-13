import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//: ## URLSession Cookbook 2: POST DataTask
let session = URLSession(configuration: .ephemeral)
//: ### HTTP Headers of GET DataTask
let url = URL(string: "http://localhost:3000/posts/")!
let task = session.dataTask(with: url)
task.currentRequest?.url
task.currentRequest?.description
task.currentRequest?.httpMethod
task.currentRequest?.allowsCellularAccess // = false  // error: currentRequest is read-only
task.currentRequest?.httpShouldHandleCookies
task.currentRequest?.timeoutInterval

task.currentRequest?.cachePolicy
task.currentRequest?.networkServiceType
task.currentRequest
task.currentRequest?.allHTTPHeaderFields
//: ### POST DataTask with URLRequest
//: __TODO 1 of 13:__ To create a data task with a custom request, first create your request:

//: __TODO 2 of 13:__ `URLRequest` is a struct, so declaring it as `var` allows us to modify its properties.
//: Specify a non-default cache policy and a network service type:


//: __TODO 3 of 13:__ Specify this request accesses the network only on wi-fi —
//: faster, less battery drain, and it preserves the user's data quota:

//: __TODO 4 of 13:__ When the request is ready, create the data task:

//: __TODO 5 of 13:__ Check the task's `httpMethod` property:

//: __TODO 6 of 13:__ Change the request's `httpMethod` property to __POST__:

//: __TODO 7 of 13:__ To send JSON, not an encoded form, set the header field __content-type__ to __application/json__:

//: __TODO 8 of 13:__ A POST task __sends__ data, so JSON-encode a `Post` object for the request's `httpBody`:
struct Post: Codable {
  let id: Int
  let author: String
  let title: String
}





//: __TODO 9 of 13:__ Check the `taskWithRequest` properties:

//: __TODO 10 of 13:__ Just one setting shows that you must set up the request completely _before_ creating the task, so create another task, with the now-complete `request`, and set up its handler to JSON-decode the response data:





//: __TODO 11 of 13:__ Check the task's `httpMethod`, header fields and `httpBody`:



//: __TODO 12 of 13:__ `resume` the task, to run it:

//: __TODO 13 of 13:__ Comment out the `resume` line, then check the task's `httpBody` again:

