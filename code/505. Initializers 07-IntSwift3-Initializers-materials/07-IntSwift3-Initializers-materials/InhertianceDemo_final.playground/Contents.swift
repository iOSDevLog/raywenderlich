//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Page {
  var words = 0
}

class Story {
  var title: String
  var author: String
  var date: Int
  var pages: [Page]
  
  init(title: String, author: String, date: Int) {
    self.title = title
    self.author = author
    self.date = date
    pages = [Page]()
  }
  
  convenience init(title:String) {
    self.init(title:title, author: "Unknown", date:2016)
  }
  
  func addPage(page: Page) {
    pages.append(page)
  }
}

class ShortStory: Story {
  var maxPageCount: Int
  
  init() {
    maxPageCount = 2
    super.init(title: "Untitled Story", author: "Author Unknown", date: 2016)
  }
  
  override func addPage(page: Page) {
    if pages.count < maxPageCount {
      super.addPage(page: page)
    }
  }
}

var story = ShortStory()
story.title = "The Haunting of Hill House"
story.addPage(page: Page(words: 300))
story.addPage(page: Page(words: 300))
story.addPage(page: Page(words: 300))
story.pages.count