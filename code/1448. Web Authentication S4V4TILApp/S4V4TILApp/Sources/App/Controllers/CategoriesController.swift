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

struct CategoriesController: RouteCollection {
  func boot(router: Router) throws {
    let categoriesRoutes = router.grouped("api", "categories")
    categoriesRoutes.post(use: createHandler)
    categoriesRoutes.get(use: getAllHandler)
    categoriesRoutes.get(Category.parameter, use: getHandler)
    categoriesRoutes.get(Category.parameter, "acronyms", use: getAcronymsHandler)
  }

  func createHandler(_ req: Request) throws -> Future<Category> {
    return try req.content.decode(Category.self).flatMap(to: Category.self) { category in
      return category.save(on: req)
    }
  }

  func getAllHandler(_ req: Request) throws -> Future<[Category]> {
    return Category.query(on: req).all()
  }

  func getHandler(_ req: Request) throws -> Future<Category> {
    return try req.parameter(Category.self)
  }

  func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
    return try req.parameter(Category.self).flatMap(to: [Acronym].self) { category in
      return try category.acronyms.query(on: req).all()
    }
  }
}

extension Category: Parameter {}

//import Authentication
//import Fluent
//
//
//public struct RedirectMiddleware<A>: Middleware where A: Authenticatable {
//
//  let path: String
//
//  public init(A authenticableType: A.Type = A.self, path: String) {
//    self.path = path
//  }
//
//  public func respond(to request: Request, chainingTo next: Responder) throws -> Future<Response> {
//    if try request.isAuthenticated(A.self) {
//      return try next.respond(to: request)
//    }
//    return Future(request.redirect(to: path))
//  }
//}
