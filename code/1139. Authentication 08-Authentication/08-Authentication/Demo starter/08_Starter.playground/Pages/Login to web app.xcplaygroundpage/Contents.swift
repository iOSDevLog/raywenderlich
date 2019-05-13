//: [<< Create new user](@previous)

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
//: ### Login to web app
//: __TODO 1 of 4:__ Copy and paste the `user` from the previous page:

//: __TODO 2 of 4:__ Combine user's email and password, and encode in base64:




//: __TODO 3 of 4:__ Create a POST `URLRequest` with `loginEndpoint`:




//: __TODO 4 of 4:__ Create a data task with `loginRequest`:





