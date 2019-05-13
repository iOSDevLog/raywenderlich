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
import Authentication

struct UsersController: RouteCollection {
  func boot(router: Router) throws {
    let usersRoutes = router.grouped("api", "users")
    usersRoutes.post(use: createHandler)
    usersRoutes.get(use: getAllHandler)
    usersRoutes.get(User.Public.parameter, use: getHandler)
    usersRoutes.get(User.parameter, "acronyms", use: getAcronymsHandler)

    let basicAuthMiddleware = User.basicAuthMiddleware(using: BCryptVerifier())
    let basicAuthGroup = usersRoutes.grouped(basicAuthMiddleware)
    basicAuthGroup.post("login", use: loginHandler)
  }

  func createHandler(_ req: Request) throws -> Future<User> {
    return try req.content.decode(User.self).flatMap(to: User.self) { user in
      let hasher = try req.make(BCryptHasher.self)
      user.password = try hasher.make(user.password)
      return user.save(on: req)
    }
  }

  func getAllHandler(_ req: Request) throws -> Future<[User.Public]> {
    return User.Public.query(on: req).all()
  }

  func getHandler(_ req: Request) throws -> Future<User.Public> {
    return try req.parameter(User.Public.self)
  }

  func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
    return try req.parameter(User.self).flatMap(to: [Acronym].self){ user in
      return try user.acronyms.query(on: req).all()
    }
  }

  func loginHandler(_ req: Request) throws -> Future<Token> {
    let user = try req.requireAuthenticated(User.self)
    let token = try Token.generate(for: user)
    return token.save(on: req)
  }

}

extension User: Parameter {}
extension User.Public: Parameter {}
