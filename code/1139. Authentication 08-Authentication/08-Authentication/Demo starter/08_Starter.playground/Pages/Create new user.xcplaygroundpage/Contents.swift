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
//: __TODO 1 of 4:__ To create a new user, start by creating a POST `URLRequest` with `newUserEndpoint`:




//: __TODO 2 of 4:__ Create a new User object, with your name etc.:

//: __TODO 3 of 4:__ Assign JSON-encoded `user` to `httpBody`:




//: __TODO 4 of 4:__ Create a data task with `newUserRequest`:




//: Copy your User object from TODO 2, then continue to the next page.
//:
//: [Login to web app >>](@next)
