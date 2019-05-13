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
//: __DONE 1 of 4:__ Copy and paste the `user` from the previous page:
let user = User(name: "jo", email: "jo@razeware.com", password: "password")
//: __DONE 2 of 4:__ Combine user's email and password, and encode in base64:
let loginString = "\(user.email):\(user.password)"
let loginData = loginString.data(using: .utf8)
let encodedString = loginData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//: __DONE 3 of 4:__ Create a POST `URLRequest` with `loginEndpoint`:
var loginRequest = URLRequest(url: loginEndpoint!)
loginRequest.httpMethod = "POST"
loginRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json",
  "authorization": "Basic \(encodedString)"
]
//: __DONE 4 of 4:__ Create a data task with `loginRequest`:
var auth = Auth(token: "")
session.dataTask(with: loginRequest) { data, response, error in
  guard let response = response, let data = data else {PlaygroundPage.current.finishExecution() }
  print(response)
  do {
    auth = try decoder.decode(Auth.self, from: data)
    auth.token
  } catch let decodeError as NSError {
    print("Decoder error: \(decodeError.localizedDescription)\n")
    return
  }
  PlaygroundPage.current.finishExecution()
  }.resume()
