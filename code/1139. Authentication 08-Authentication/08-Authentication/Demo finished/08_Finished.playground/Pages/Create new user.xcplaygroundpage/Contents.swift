import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Authentication: How to login to get an authentication token
let config = URLSessionConfiguration.default
config.waitsForConnectivity = true
let session = URLSession(configuration: config)
//: Endpoints for web app:
let baseURL = URL(string: "https://tilftw.herokuapp.com/")
let newUserEndpoint = URL(string: "users", relativeTo: baseURL)
let loginEndpoint = URL(string: "login", relativeTo: baseURL)
//: `Codable` structs for User, Acronym, Auth:
struct User: Codable {
  let name: String
  let email: String
  let password: String
}

struct Acronym: Codable {
  let short: String
  let long: String
}

struct Auth: Codable {
  let token: String
}

let encoder = JSONEncoder()
let decoder = JSONDecoder()
//: ### Create a new user:
//: __DONE 1 of 4:__ To create a new user, start by creating a POST `URLRequest` with `newUserEndpoint`:
var newUserRequest = URLRequest(url: newUserEndpoint!)
newUserRequest.httpMethod = "POST"
newUserRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json"
]
//: __DONE 2 of 4:__ Create a new User object, with your name etc.:
let user = User(name: "jo", email: "jo@razeware.com", password: "password")
//: __DONE 3 of 4:__ Assign JSON-encoded `user` to `httpBody`:
do {
  newUserRequest.httpBody = try encoder.encode(user)
} catch let encodeError as NSError {
  print("Encoder error: \(encodeError.localizedDescription)\n")
  PlaygroundPage.current.finishExecution()
}
//: __DONE 4 of 4:__ Create a data task with `newUserRequest`:
session.dataTask(with: newUserRequest) { _, response, _ in
  guard let response = response else {PlaygroundPage.current.finishExecution() }
  print(response)
  PlaygroundPage.current.finishExecution()
}.resume()
//: Copy your User object from TODO 2, then continue to the next page.
//:
//: [Login to web app >>](@next)
