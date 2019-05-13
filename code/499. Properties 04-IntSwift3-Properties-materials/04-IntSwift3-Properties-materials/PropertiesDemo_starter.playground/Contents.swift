//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Book {
  var title: String
}

struct Author {
  var firstName: String
  var lastName: String
  var books: [Book] = []
  
  mutating func addBook(_ aBook: Book) {
    books.append(aBook)
  }
  
}

var theDarkTower = Book(title: "The Dark Tower")
var theStand = Book(title: "The Stand")

var writer = Author(firstName: "Stephen", lastName: "King", books: [theStand])
var anotherBook = Book(title: "The Gungslinger")
writer.addBook(anotherBook)



