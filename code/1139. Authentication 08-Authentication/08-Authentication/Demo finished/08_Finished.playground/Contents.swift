import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: ## Authentication: How to get and use authentication tokens
let session = URLSession(configuration: .ephemeral)
//: Helper function to extract JSON result:
typealias JSONDictionary = [String: Any]
func checkResponse(data: Data?, response: URLResponse?, error: Error?) -> JSONDictionary? {
  if let error = error { print(error.localizedDescription) }
  if let response = response { print(response) }
  guard let data = data, let response = response as? HTTPURLResponse else { return nil }
  if response.statusCode != 200 {
    response.statusCode
    return nil
  }
  
  var jsonResult: JSONDictionary?
  do {
    jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
  } catch {
    print(error.localizedDescription)
    return nil
  }
  return jsonResult
}
//: ### Login to Stormpath Notes:
//: This demo uses a REST service set up by Stormpath to demonstrate their authentication framework.
//: Although we won't use their framework for this demo or the challenge.
//:
//: [Stormpath Notes](https://stormpath.com/blog/build-note-taking-app-swift-ios)
//: is a simple app that lets users login, edit and save notes on the Notes server.
//: I've already registered a user, and added some notes.
//: #### Getting the authentication token
//: Authentication tokens and info returned by OpenID Connect login:
var accessToken: String?
var refreshToken: String?
var tokenType: String?
var expires_in: Int?
var accessTokenHref: String?
//: Start by creating a POST `URLRequest` with the login URL. 
//: The server requires a custom header "x-stormpath-agent":
var loginRequest = URLRequest(url: URL(string: "https://stormpathnotes.herokuapp.com/oauth/token")!)
loginRequest.httpMethod = "POST"
loginRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json",
  "x-stormpath-agent": "stormpath-sdk-ios/2.0.1 iOS/10.2",
]
//: The login request's body speciifes the grant type, and includes the user's login details. 
//: The request will be encrypted before it's sent.
let dictionary = ["grant_type": "password",
                  "password": "123;Abcz",
                  "username": "eugeneivanov3@gmail.com"] as JSONDictionary
let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
loginRequest.httpBody = data
//: Create the task, with the request and completion handler:
let loginTask = session.dataTask(with: loginRequest) { data, response, error in
  guard let jsonResult = checkResponse(data: data, response: response, error: error) else {
    PlaygroundPage.current.finishExecution()
  }
//: Extract the authentication values from the response:
  accessToken = jsonResult["access_token"] as? String
  refreshToken = jsonResult["refresh_token"] as? String
  tokenType = jsonResult["token_type"] as? String
  expires_in = jsonResult["expires_in"] as? Int
  accessTokenHref = jsonResult["stormpath_access_token_href"] as? String
//: #### Using the authentication token
//: Now create a GET request with the notes URL:
  var requestNotes = URLRequest(url: URL(string: "https://stormpathnotes.herokuapp.com/notes")!)
  requestNotes.httpMethod = "GET"
  requestNotes.setValue("application/json", forHTTPHeaderField: "content-type")
  requestNotes.setValue("\(tokenType!) \(accessToken!)", forHTTPHeaderField: "authorization")
  //Uncomment the next line if you want to check the header fields:
  requestNotes.allHTTPHeaderFields
  
  session.dataTask(with: requestNotes) { data, response, error in
    guard let jsonResult = checkResponse(data: data, response: response, error: error) else {
      PlaygroundPage.current.finishExecution()
    }
    
    jsonResult["notes"]
    PlaygroundPage.current.finishExecution()
    }.resume()
}
// TODO: Comment out the next line before continuing to the Register section
loginTask.resume()
//: #### Register at Stormpath Notes
//: Before doing the challenge, register to create your own Stormpath Notes account:
var registerRequest = URLRequest(url: URL(string: "https://stormpathnotes.herokuapp.com/register")!)
registerRequest.httpMethod = "POST"
registerRequest.allHTTPHeaderFields = [
  "accept": "application/json",
  "content-type": "application/json"
]
// TODO: Change the email address to something else — the Notes server doesn't allow 2 accounts with the same email address
let parameters = ["email": "someone3@some.server",
                  "password": "987;Poiuy",
                  "givenName": "Your",
                  "surname": "Name"] as JSONDictionary
let bodyData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
registerRequest.httpBody = bodyData
// TODO: Uncomment this code, then run to register
//sharedSession.dataTask(with: registerRequest) { data, response, error in
//  let _ = checkResponse(data: data, response: response, error: error)
//  PlaygroundPage.current.finishExecution()
//  }.resume()
