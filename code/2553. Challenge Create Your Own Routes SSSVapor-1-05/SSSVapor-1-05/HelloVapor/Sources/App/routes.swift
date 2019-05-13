/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
  // Basic "It works" example
  router.get { req in
    return "It works!"
  }

  // Basic "Hello, world!" example
  router.get("hello") { req in
    return "Hello, world!"
  }

  router.get("hello", "vapor") { req in
    return "Hello Vapor!"
  }

  router.get("hello", String.parameter) { req -> String in
    let name = try req.parameters.next(String.self)
    return "Hello \(name)!"
  }

  router.post("info") { req -> InfoResponse in
    let data = try req.content.syncDecode(InfoData.self)
    return InfoResponse(request: data)
  }

  router.get("date") { req in
    return "\(Date())"
  }

  router.get("counter", Int.parameter) { req -> CountJSON in
    let count = try req.parameters.next(Int.self)
    return CountJSON(count: count)
  }

  router.post("user-info") { req -> String in
    let userInfo = try req.content.syncDecode(UserInfoData.self)
    return "Hello \(userInfo.name), you are \(userInfo.age)!"
  }

  // Example of configuring a controller
  let todoController = TodoController()
  router.get("todos", use: todoController.index)
  router.post("todos", use: todoController.create)
  router.delete("todos", Todo.parameter, use: todoController.delete)
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
