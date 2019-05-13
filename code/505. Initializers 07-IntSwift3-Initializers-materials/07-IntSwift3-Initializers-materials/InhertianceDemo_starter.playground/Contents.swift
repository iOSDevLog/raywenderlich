//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Page {
  var words = 0
}

class Story {
  var title = ""
  var pages: [Page] = []
  
  func addPage(page: Page) {
    pages.append(page)
  }
}

class ShortStory: Story {
  var maxPageCount = 2
  
  override func addPage(page: Page) {
    if pages.count < maxPageCount {
      super.addPage(page: page)
    }
  }
}