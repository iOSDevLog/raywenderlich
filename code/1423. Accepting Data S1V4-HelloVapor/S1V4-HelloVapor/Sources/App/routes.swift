import Routing
import Vapor

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
}

struct InfoData: Content {
  let name: String
}

struct InfoResponse: Content {
  let request: InfoData
}















