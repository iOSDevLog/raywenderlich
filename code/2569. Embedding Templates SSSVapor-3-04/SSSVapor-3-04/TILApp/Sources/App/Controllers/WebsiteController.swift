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

struct WebsiteController: RouteCollection {
  func boot(router: Router) throws {
    router.get(use: indexHandler)
    router.get("acronyms", Acronym.parameter, use: acronymHandler)
    router.get("users", User.parameter, use: userHandler)
  }
  
  func indexHandler(_ req: Request) throws -> Future<View> {
    return Acronym.query(on: req).all().flatMap(to: View.self) { acronyms in
      let context = IndexContext(title: "Homepage", acronyms: acronyms.isEmpty ? nil : acronyms)
      return try req.view().render("index", context)
    }
  }
  
  func acronymHandler(_ req: Request) throws -> Future<View> {
    return try req.parameters.next(Acronym.self).flatMap(to: View.self) { acronym in
      return acronym.user.get(on: req).flatMap(to: View.self) { user in
        let context = AcronymContext(title: acronym.long, acronym: acronym, user: user)
        return try req.view().render("acronym", context)
      }
    }
  }
  
  func userHandler(_ req: Request) throws -> Future<View> {
    return try req.parameters.next(User.self).flatMap(to: View.self) { user in
      let context = try UserContext(title: user.name, user: user, acronyms: user.acronyms.query(on: req).all())
      return try req.view().render("user", context)
    }
  }
}

struct IndexContext: Encodable {
  let title: String
  let acronyms: [Acronym]?
}

struct AcronymContext: Encodable {
  let title: String
  let acronym: Acronym
  let user: User
}

struct UserContext: Encodable {
  let title: String
  let user: User
  let acronyms: Future<[Acronym]>
}
