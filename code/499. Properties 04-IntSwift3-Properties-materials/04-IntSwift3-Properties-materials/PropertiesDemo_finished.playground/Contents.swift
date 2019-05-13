//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Book {
  var title: String
  var isPublished: Bool
}

struct Author {
  var firstName: String
  var lastName: String
  var booksWritten: [Book] = []
  var booksBeingWritten: [Book] = []
  var books: [Book] {
    get {
      return booksWritten
    }
  }
  var totalBooks: Int {
    return booksBeingWritten.count + booksWritten.count
  }
  
  
  mutating func addBook(_ aBook: Book) {
    if aBook.isPublished {
      booksWritten.append(aBook)
    } else {
      booksBeingWritten.append(aBook)
    }
  }
  
}

var theDarkTower = Book(title: "The Dark Tower", isPublished: true)
var theStand = Book(title: "The Stand", isPublished: true)

var writer = Author(firstName: "Stephen", lastName: "King", booksWritten: [theStand], booksBeingWritten:[])
var anotherBook = Book(title: "The Gungslinger", isPublished: true)
writer.addBook(anotherBook)

var unPublishedBook = Book(title: "Untitled Project", isPublished: false)
writer.addBook(unPublishedBook)
writer.booksBeingWritten

print(writer.totalBooks)







