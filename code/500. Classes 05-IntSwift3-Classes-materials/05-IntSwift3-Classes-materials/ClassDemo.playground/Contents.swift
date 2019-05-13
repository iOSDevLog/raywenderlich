//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Movie {
  var title: String
  var runningTime: Int
  
  init(title:String, runningTime: Int) {
    self.title = title
    self.runningTime = runningTime
  }
}

var adventureMovie = Movie(title: "Raiders of the Lost Ark", runningTime: 90)
let scienceFictionMovie = adventureMovie

scienceFictionMovie.title = "2001"
print(adventureMovie.title)
print(scienceFictionMovie.title)

print(adventureMovie === scienceFictionMovie)
scienceFictionMovie = Movie(title: "The Martian", runningTime: 120)
print(scienceFictionMovie.title)

print(adventureMovie === scienceFictionMovie)


