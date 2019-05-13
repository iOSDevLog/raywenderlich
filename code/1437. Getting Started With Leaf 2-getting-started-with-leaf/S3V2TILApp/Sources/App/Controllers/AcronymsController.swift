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
import Fluent

struct AcronymsController: RouteCollection {
  func boot(router: Router) throws {
    let acronymsRoute = router.grouped("api", "acronyms")
    acronymsRoute.get(use: getAllHandler)
    acronymsRoute.post(use: createHandler)
    acronymsRoute.get(Acronym.parameter, use: getHandler)
    acronymsRoute.delete(Acronym.parameter, use: deleteHandler)
    acronymsRoute.put(Acronym.parameter, use: updateHandler)
    acronymsRoute.get(Acronym.parameter, "creator", use: getCreatorHandler)
    acronymsRoute.get(Acronym.parameter, "categories", use: getCategoriesHandler)
    acronymsRoute.post(Acronym.parameter, "categories", Category.parameter, use: addCategoriesHandler)
    acronymsRoute.get("search", use: searchHandler)
  }

  func getAllHandler(_ req: Request) throws -> Future<[Acronym]> {
    return Acronym.query(on: req).all()
  }

  func createHandler(_ req: Request) throws -> Future<Acronym> {
    let acronym = try req.content.decode(Acronym.self).await(on: req)
    return acronym.save(on: req)
  }

  func getHandler(_ req: Request) throws -> Future<Acronym> {
    return try req.parameter(Acronym.self)
  }

  func deleteHandler(_ req: Request) throws -> Future<HTTPStatus> {
    return try req.parameter(Acronym.self).flatMap(to: HTTPStatus.self) { acronym in
      return acronym.delete(on: req).transform(to: HTTPStatus.noContent)
    }
  }

  func updateHandler(_ req: Request) throws -> Future<Acronym> {
    return try flatMap(to: Acronym.self, req.parameter(Acronym.self), req.content.decode(Acronym.self)) { acronym, updatedAcronym in
      acronym.short = updatedAcronym.short
      acronym.long = updatedAcronym.long
      return acronym.save(on: req)
    }
  }

  func getCreatorHandler(_ req: Request) throws -> Future<User> {
    return try req.parameter(Acronym.self).flatMap(to: User.self) { acronym in
      return acronym.creator.get(on: req)
    }
  }

  func getCategoriesHandler(_ req: Request) throws -> Future<[Category]> {
    return try req.parameter(Acronym.self).flatMap(to: [Category].self) { acronym in
      return try acronym.categories.query(on: req).all()
    }
  }

  func addCategoriesHandler(_ req: Request) throws -> Future<HTTPStatus> {
    return try flatMap(to: HTTPStatus.self, req.parameter(Acronym.self), req.parameter(Category.self)) { acronym, category in
      let pivot = try AcronymCategoryPivot(acronym.requireID(), category.requireID())
      return pivot.save(on: req).transform(to: .ok)
    }
  }

  func searchHandler(_ req: Request) throws -> Future<[Acronym]> {
    guard let searchTerm = req.query[String.self, at: "term"] else {
      throw Abort(.badRequest)
    }
    return Acronym.query(on: req).group(.or) { or in
      or.filter(\.short == searchTerm)
      or.filter(\.long == searchTerm)
    }.all()
  }
}

extension Acronym: Parameter {}
