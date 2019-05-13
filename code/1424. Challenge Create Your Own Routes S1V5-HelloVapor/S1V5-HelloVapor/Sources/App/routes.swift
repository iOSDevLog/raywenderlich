import Routing
import Vapor
import Foundation

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of creating a Service and using it.
    router.get("hash", String.parameter) { req -> String in
        // Create a BCryptHasher using the Request's Container
        let hasher = try req.make(BCryptHasher.self)

        // Fetch the String parameter (as described in the route)
        let string = try req.parameter(String.self)

        // Return the hashed string!
        return try hasher.make(string)
    }
  
  router.get("hello", "vapor") { req in
    return "Hello Vapor"
  }
  
  router.get("hello", String.parameter) { req -> String in
    let name = try req.parameter(String.self)
    return "Hello \(name)!"
  }
  
  router.post("info") { req -> InfoResponse in
    let data = try req.content.decode(InfoData.self).await(on: req)
    return InfoResponse(request: data)
  }
  
  router.get("date") { req in
    return "\(Date())"
  }
  
  router.get("counter", Int.parameter) { req -> CountJSON in
    let count = try req.parameter(Int.self)
    return CountJSON(count: count)
  }
  
  router.post("user-info") { req -> String in
    let userInfo = try req.content.decode(UserInfoData.self).await(on: req)
    return "Hello \(userInfo.name), you are \(userInfo.age)!"
  }
}

struct InfoData: Content {
  let name: String
}

struct InfoResponse: Content {
  let request: InfoData
}

struct CountJSON: Content {
  let count: Int
}

struct UserInfoData: Content {
  let name: String
  let age: Int
}















